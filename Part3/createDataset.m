% Author: Surya Kalia
% Summary: To create a dataset with odometery from Google Tango device and
% hi-res images from iPhone.
%
% Input : Tango Data and MOV file from iPhone.
% Output : txt file conatining Pose info. MAT file containing Odometry and Point Clouds.
% Output Format: txt file: <img_path> <translation x-y-z)> <rotation quaternion>
% Output Format: MAT file: <iPhonePoses> <iPhonePoints>

mainFolder = pwd;

% Specify Folder containing Tango Data
dataPath = '/l/Surya_Tango_Data/Final_Dataset/Meeting/seq_01_copy/seq_01_raw'
dataSet = strsplit(dataPath,'/');
dataSet = dataSet{end};
folder = [dataPath];

% Specify path of MOV file
MOVfolder = '/l/Surya_Tango_Data/Final_Dataset/Meeting/seq_01_copy/seq_01_images'

% Specify name of MOV file
MOVname = 'Meeting_Seq_01_new.MOV'
MOVpath = [MOVfolder '/' MOVname];


if ispc
   folder = convertFileNames(folder);
end

outFolder = fullfile(folder,'matlab');
imagesFolder = fullfile(folder,'images');
odometryFolder = fullfile(folder,'odometry');


if ~exist(folder,'dir')
   unzip([folder '.zip'],folder);
end

[~,~] = mkdir(outFolder);
[~,~] = mkdir(imagesFolder);
[~,~] = mkdir(odometryFolder);
outFile = fullfile(outFolder,[dataSet '_matlab.mat']);

%% Import Tango Data
[tangoPoints,tangoTimes,tangoPoses,tangoPoseCam2Dev,pointFiles,validPointFiles] = vtkImportTangoData(folder);
tangoPoints = tangoPoints(validPointFiles);
tangoTimes = tangoTimes(validPointFiles);

save(outFile);

%% Map to World Coordinates
[TangoPointsWorld_SS,TangoPosesWorld_SS,TangoPointsWorld_AL,TangoPosesWorld_AL] = mapTangoToWorld(tangoPoints,tangoTimes,tangoPoses,tangoPoseCam2Dev,folder,pointFiles(validPointFiles));

%% Calculate fps of Tango measurements and extract frames from iPhone MOV

fps = length(tangoTimes) ./(tangoTimes(end) - tangoTimes(1));

cd(MOVfolder);
system(['ffmpeg -i ' MOVname ' -vf fps=' sprintf('%0.3f',fps) ' ' imagesFolder '/frame--%05d.png -hide_banner'])
cd(mainFolder);

sprintf(['iPhone images extarcted to the following location: ' imagesFolder]);
%% Synchronize images with odometry
% Visually check which Tango image matches which iPhone image.


D = dir([imagesFolder, '/*.png']);
numImages = length(D(not([D.isdir])));

sprintf(['Visually compare iPhone and Tango images to identify one pair corresponding to same scene. \nFor Tango image, search in: ' dataPath '\nFor iPhone image, seaerch in: '  imagesFolder]);

tangoIndex = input('Tango Image Index: ');
iPhoneIndex = input('iPhone Image Index: ');

iPhoneTimes = zeros(numImages,1);
iPhoneTimes(iPhoneIndex) = tangoTimes(tangoIndex);

for i = iPhoneIndex:size(iPhoneTimes,1)
    iPhoneTimes(i+1) = iPhoneTimes(i) + (1./fps);
end

for i = iPhoneIndex-1 :-1:1
    iPhoneTimes(i) = iPhoneTimes(i+1) - (1./fps);
end

% nearest_lesser would indicate whether the given iPhone frame has
% corresponding Tango odometry data based on extrapolated 'iPhoneTimes' timestamps
nearest_lesser = create_split (tangoTimes, iPhoneTimes);


for i = 1:length(iPhoneTimes)
    if nearest_lesser(i) >= 1
        first_valid = i;
        break
    end
end

for i = length(iPhoneTimes): -1:1
    if nearest_lesser(i) ~= 0 && nearest_lesser(i) < length(tangoTimes)
        last_valid = i;
        break
    end
end

first_img = input(['Index of first iPhone image to include in dataset (greater than ' sprintf('%d',first_valid) '): ']);
last_img = input(['Index of last iPhone image to include in dataset (lesser than ' sprintf('%d',last_valid) '): ']);

num_final_images = last_img - first_img + 1;

%% Generating Pose.TXT file, PointClouds.MAT and Final Dataset Images

seq_number = input('Specify seq_name prefix (eg. seq_01): ','s');

[iPhonePoses,iPhonePoints] = GeneratePoseTxtFiles(TangoPosesWorld_SS, TangoPointsWorld_SS, [dataSet '_poses.txt'], first_img, num_final_images,odometryFolder, nearest_lesser,seq_number);
save([odometryFolder '/' dataSet '.mat'], 'iPhonePoses', 'iPhonePoints');

% Format Dataset Images

FormatDatasetImages(imagesFolder, first_img, last_img, numImages);

sprintf(['The output dataset images are in: ' imagesFolder '\nThe output pose.txt file and MAT file is in :' odometryFolder ]);



