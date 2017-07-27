% Author: Surya Kalia
% Description: To correct drift in Tango Odometry in a semi-automated
% procedure using anchor points on floor plan as ground truths.


dataPath = 'Surya_Tango_Data/Final_Dataset/Corridoor/seq_01/seq_01_raw'


dataSet = strsplit(dataPath,'/');
dataSet = dataSet{end};
folder = ['/l/' dataPath];

if ispc
   folder = convertFileNames(folder);
end

outFolder = fullfile(folder,'matlab');

if ~exist(folder,'dir')
   unzip([folder '.zip'],folder);
end

[~,~] = mkdir(outFolder);
outFile = fullfile(outFolder,[dataSet '_matlab.mat']);

%% Import data
[TangoPoints,tangoTimes,tangoPose,tangoPoseCam2Dev,pointFiles,validPointFiles] = vtkImportTangoData(folder);
TangoPoints = TangoPoints(validPointFiles);
tangoTimes = tangoTimes(validPointFiles);
%pointFiles = pointFiles(validPointFiles);
%validPointFiles = true(length(validPointFiles),1);

save(outFile);

%% Map to world coordinates (iphoneTimes -- No points!!)
[TangoPointsWorld_SS,TangoPosesWorld_SS,TangoPointsWorld_AL,TangoPosesWorld_AL] = mapTangoToWorld(TangoPoints,tangoTimes,tangoPose,tangoPoseCam2Dev,folder,pointFiles(validPointFiles));
save(outFile,'TangoPointsWorld_SS','TangoPosesWorld_SS','TangoPointsWorld_AL','TangoPosesWorld_AL','-append');


%% Rotation transformation for point clouds
% rot_normalization =
% 
%     0.9976    0.0151   -0.0670         0
%     0.0645    0.1295    0.9895         0
%     0.0236   -0.9915    0.1282         0
%          0         0         0    1.0000
% %%

% post multiply. So Tango * final_rot gives the rot in image frame
final_rot = [[0.9975    0.0228   -0.0670]
    [0.0635    0.1300    0.9895]
    [0.0313   -0.9912    0.1282]];


final_rot_4x4 = [[0.9975    0.0228   -0.0670   -0.0185]
    [0.0635    0.1300    0.9895   -0.0002]
    [0.0313   -0.9912    0.1282   -0.0071]
         [0         0         0    1.0000]];

%% Queries for type of input


% TangoPoseInternal = TangoPosesRGB_SS;
TangoPoseName = input('Enter index of TangoPose dataset to use: \n 1: TangoPosesRGB_SS \n 2: TangoPosesRGB_AL \n 3: TangoPosesWorld_SS \n 4: TangoPosesWorld_AL \n','s');

if TangoPoseName == '1'
    TangoPoseInternal = TangoPosesRGB_SS;
elseif TangoPoseName == '2'
    TangoPoseInternal = TangoPosesRGB_AL;
elseif TangoPoseName == '3'
    TangoPoseInternal = TangoPosesWorld_SS;
elseif TangoPoseName == '4'
    TangoPoseInternal = TangoPosesWorld_AL;
else sprintf('Incorrect Input!');
    
end
    
rot_corr = input('Apply rot correction to Tango Data? y/n \n','s');

if rot_corr == 'y'
    for i = 1:size(TangoPoseInternal,1)
        TangoPoseInternal{i}(1:4,1:4) = TangoPoseInternal{i}(1:4,1:4)* final_rot_4x4;
    end
elseif rot_corr == 'n'
else sprintf('Incorrect Input!');
    
end


%% Downsample TangoPoseInternal and generate z2

TangoPoseInternalDownspl = cell(fix(size(TangoPoseInternal, 1)/3),1);

mode = input('Choose mode: \n 1: Only translation optimization(without z) \n 2: Only translation optimization(with z) \n 3: Both rot+trans without absolute rotation constraint \n 4: Complete optimization y/n \n','s');



k=1;
z2_row = fix(size(TangoPoseInternal,1)/3);
z2 = zeros (z2_row, 6);
for i= 1:size(TangoPoseInternal, 1)
    if mod(i,3) == 0
        TangoPoseInternalDownspl{k} = TangoPoseInternal{i};
        z2(k,1:3) = (TangoPoseInternal{i}(1:3,4))';
        if mode == '1'
            z2(k,3) = 0;
        end
        
        z2(k,4:6) = rotationMatrixToVector(TangoPoseInternal{i}(1:3,1:3));
        k = k+1;
    end
end


%% Constraints. Generated from Part1 python code by choosing points on floor plan corresponding to anchor points.


tra_constraints = [[  0.        -0.      0.]
 [  0.101751  24.216738 0.]
 [  1.729767  64.747553 0.]
 [ 38.427961  59.626086 0.]
 [ 33.069075  23.538398 0.]
 [ 30.287881  -9.632428 0.]];

tra_constraints(:,[i,j,k])=tra_constraints(:,[j,i,k]);  % to get format as x,y,z


% rel is between consecutive checkerboards
rel_rotation_constraints_quats = [[0. 0. 0. 0.]
    [0, 0, 0.7521261196102685, 0.6590191956233141]
    [0. 0. 0. 0.]
    [0, 0, 0.7057639841335063, 0.708447033094218]
    [0. 0. 0. 0.]
    [0, 0, 0.9979490718218039, 0.06401288971761823]];


rel_rotation_constraints_angax = [[0., 0., 0.]
    [0, 0, 1.70256470918]
    [0., 0., 0.]
    [0, 0, 1.56700192029]
    [0., 0., 0.]
    [0, 0, 3.0134792784]];

% with respect to the image coordinate system keeping origin pose as along
% +ve y dirn (downwards)

abs_rot_constraints_angax = [[0. 0. 0.00774598605746]
    [0. 0. 0.00774598605746]
    [0. 0. 1.70901601377]
    [0. 0. 1.70901601377]
    [0. 0. -3.00710382156]
    [0. 0. -3.00710382156]];

% Indicate Tango frame number/3 which has the checkboard anchor image
constraint_index = [2    43    96   145   195   240   297   323   370   411];

% Sequence of anchor points in order of appearance
constaraint_anchor_no = [1,2,3,4,5,6,1,2,5,6];


%% Reshaping z2 into z2_in

[z2_row,z2_col] = size(z2)
[constraint_index_row,constraint_index_col] = size(constraint_index);
z2_in = reshape(z2,1,z2_row*z2_col);

%% Constructing Jacobian
 
J = constructJacobian_2(z2_row,constraint_index_col,constraint_index, mode);

%% Optimization


options = optimset('LargeScale','on',...
    'Jacobian', 'off', ...
    'Algorithm','Trust-Region-Reflective',...
    'JacobPattern', J, ...
    'Display','iter', ...
    'TolFun',1e-14,...
    'TolX',1e-7,...
    'MaxFunEvals',20000,...
    'MaxIter',100);


x_ans_2 = lsqnonlin(@(x) double(cost_fn_2(x,tra_constraints, abs_rot_constraints_angax, constraint_index,constaraint_anchor_no, TangoPoseInternalDownspl, mode)),double(z2_in),[],[],options);


x_ans_2 = reshape(x_ans_2,z2_row,z2_col);
    

%% Reconstructing missing data points

reconstructed = zeros(size(TangoPoseInternal,1),6);
for i = 1:size(TangoPoseInternal,1)
    i_3 = fix(i/3);
    if i ==1 || i==2 
        reconstructed (i,1:3) = (TangoPoseInternal{i}(1:3,4))' ;
        reconstructed(i,4:6) = rotationMatrixToVector(TangoPoseInternal{i}(1:3,1:3));
    elseif mod(i,3) == 0
        reconstructed(i,:) = x_ans_2(i_3,:);
    else
        reconstructed(i,1:3) = x_ans_2(i_3,1:3) + ( TangoPoseInternal{i}(1:3,4) - TangoPoseInternal{i_3 * 3}(1:3,4))' ;
        reconstructed(i,4:6) = x_ans_2(i_3,4:6) + ( rotationMatrixToVector(TangoPoseInternal{i}(1:3,1:3)) - rotationMatrixToVector(TangoPoseInternal{i_3 * 3}(1:3,1:3))) ;
    end
end
        


%% Plotting Point Cloud

plot_type = input('Do you wish to plot the un-optimized data too? y/n \n','s');

k=1;
z2_row = fix(size(TangoPoseInternal,1)/3);
z2 = zeros (z2_row, 6);
for i= 1:size(TangoPoseInternal, 1)
        z2(k,1:3) = (TangoPoseInternal{i}(1:3,4))';
        z2(k,4:6) = rotationMatrixToVector(TangoPoseInternal{i}(1:3,1:3));
        k = k+1;
    
end


if plot_type == 'y'
    plot_new_point_cloud_2 (z2,TangoPoints,tangoPoseCam2Dev);
    plot_new_point_cloud_2 (reconstructed,TangoPoints,tangoPoseCam2Dev);
elseif plot_type =='n'
    plot_new_point_cloud_2 (reconstructed,TangoPoints,tangoPoseCam2Dev);
else
    sprintf('Incorrect Input!');  
end
    
