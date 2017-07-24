% Author: Surya Kalia

function [iPhonePoses,iPhonePoints] = GeneratePoseTxtFiles(PosesCopy,PointsCopy,filename,num_start,num_tot,out_directory,nearest_lesser, seq_number)

original_directory = pwd;

cd(out_directory);
fid=fopen(filename,'w');

iPhonePoses = cell (num_tot,1);
iPhonePoints = cell (num_tot,1);

for i = 1:num_tot

pose = [ (PosesCopy{nearest_lesser(i+num_start-1)}(1:3,4))' rotm2quat(PosesCopy{nearest_lesser(i+num_start-1)}(1:3,1:3))];
longstring = ['/' seq_number '/frame_' num2str(i,'%05d') '.png ' sprintf('%0.5f', pose(1)) ' ' sprintf('%0.5f', pose(2)) ' ' sprintf('%0.5f', pose(3)) ' ' sprintf('%0.5f', pose(4)) ' ' sprintf('%0.5f', pose(5)) ' ' sprintf('%0.5f', pose(6)) ' ' sprintf('%0.5f', pose(7))];
iPhonePoses{i}(1:4,1:4) = PosesCopy{nearest_lesser(i+num_start-1)};
iPhonePoints{i}(:,1:3) = PointsCopy{nearest_lesser(i+num_start-1)}(:,1:3);


fprintf(fid, [longstring '\n']);
end

fclose(fid);
cd(original_directory);


end
