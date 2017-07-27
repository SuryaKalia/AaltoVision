function [] = plot_new_point_cloud_2( New_Tango_Poses,TangoPoints ,tangoPoseCam2Dev)

%% plot output from our approach

itr = 0;

for i = 1:1240
    
    
    itr = itr +1;
    R_opt{itr}(1:3,1:3) = rotationVectorToMatrix(New_Tango_Poses(i,4:6));
    
    Opt_C_RGB(itr,1:3) = New_Tango_Poses(i,1:3);
    
    
end



%%

fileCount = 1;
% R_opt=rotationmat(Opt_Rot_RGB);
for i = 1 : 1:size(R_opt,2)
if numel(TangoPoints{fileCount}) == 0
% disp 'wtf'
fileCount = fileCount + 1;
openMVGPointsWorld{fileCount} = [];
continue;
end
points = double([TangoPoints{fileCount} ones(size(TangoPoints{fileCount},1),1)]);
pointsWorld = [R_opt{fileCount} Opt_C_RGB(fileCount,:)']*double(tangoPoseCam2Dev)*points';
pointsWorld = pointsWorld';
openMVGPointsWorld{fileCount} = pointsWorld(:,1:3);
fileCount = fileCount + 1;
end
%%
xyz = cat(1,openMVGPointsWorld{:});
% RGB = uint8(cat(1,RGB4Pts_subsampled{:}));
% % , RGB_Centers));
% 
figure('Name','MVG','Renderer','opengl'); showPointCloud(xyz);
set(gca,'visible','off');
xlabel('X');
ylabel('Y');
zlabel('Z');
end

