% Author: Surya Kalia
% Description: This is the cost function used by the lsqnonlin optimizer ofr correcting odometry 


function y = cost_fn_2 (x,tra_con,rot_con,con_ind,con_anchor_no, TangoPoses, mode)

    [x1_row,x1_col] = size(x);
    x = reshape(x,x1_col/6,6);


    [x_row,x_col] = size(x);

%     y(1,:) = x(1,:)-z(1,:);


T(:,1:3) = x(:,1:3);
   
T_tango = zeros(x_row,3);
R_angax = zeros(x_row,3);
R = cell(x_row,1);
R_tango = cell(x_row,1);
rot_con_mat = cell(size(tra_con,1),1);


for i = 1:size(x,1)
    T_tango(i,1:3) = (TangoPoses{i,1}(1:3,4))';
    
    R_angax(i,1:3) = x(i,4:6); 
    R{i} = rotationVectorToMatrix(R_angax(i,1:3));
    R_tango{i}(1:3,1:3) = TangoPoses{i}(1:3,1:3);
    
end   

for i= 1:size(tra_con,1)
    rot_con_mat{i} = rotationVectorToMatrix(rot_con(i,1:3));
    
end
    error_counter = 1;
    
   
if mode == '1'
    %% Relative Rotation Error
    
    y(error_counter:error_counter +2) = [0;0;0];
    error_counter = error_counter + 3;
    for i = 2:size(T,1)
        
        Rel_rot_var = R{i-1}'*R{i};
        Rel_rot_tango = R_tango{i-1}'*R_tango{i};
        
        Rel_rot_err_mat = Rel_rot_var'*Rel_rot_tango;
        Rel_rot_err_vec = rotationMatrixToVector(Rel_rot_err_mat);
        
        if norm(Rel_rot_err_vec) > pi
            Rel_rot_err_vec = Rel_rot_err_vec.*(1-(2*pi/norm(Rel_rot_err_vec)));
        end
        
        y(error_counter:error_counter +2) = zeros(3,1);
        error_counter = error_counter + 3;
        
    end
%     error_counter
    %% Relative Translation Error
    
    y(error_counter:error_counter +2) = [0;0;0];
    error_counter = error_counter + 3;
    for i = 2:size(T,1)
        
        Rel_tra_var = R{i-1}'*(T(i,:)' - T(i-1,:)');
        Rel_tra_tango = R_tango{i-1}'*(T_tango(i,:)' - T_tango(i-1,:)');
        
        y(error_counter:error_counter +2) = Rel_tra_var - Rel_tra_tango ;
        y(error_counter +2) = 0;
            
        error_counter = error_counter + 3;
        
    end
%     error_counter
    %% Absolute Rotation Error
%     size(con_ind,2)
    for i = 1:size(con_ind,2)
        
        Abs_rot_err_mat = R{con_ind(i)}'* rot_con_mat{con_anchor_no(i)};
        Abs_rot_err_vec = rotationMatrixToVector(Abs_rot_err_mat);
        
        if norm(Abs_rot_err_vec) > pi
            Abs_rot_err_vec = Abs_rot_err_vec.*(1-(2*pi/norm(Abs_rot_err_vec)));
        end
        
        
         y(error_counter:error_counter +2) = zeros(3,1);
%          y(error_counter:error_counter +2) = zeros(3,1);   
         error_counter = error_counter + 3;    
    
    end
%     error_counter
    %% Absolute Translation Error
    
    for i= 1:size(con_ind,2)
         y(error_counter:error_counter +2) = T(con_ind(i))' - tra_con(con_anchor_no(i))';
         y(error_counter +2) = 0;
%             y(error_counter:error_counter +2) = zeros(3,1);
         error_counter = error_counter + 3;
    
    end
    
    
elseif mode == '2'
    %% Relative Rotation Error
    
    y(error_counter:error_counter +2) = [0;0;0];
    error_counter = error_counter + 3;
    for i = 2:size(T,1)
        
        Rel_rot_var = R{i-1}'*R{i};
        Rel_rot_tango = R_tango{i-1}'*R_tango{i};
        
        Rel_rot_err_mat = Rel_rot_var'*Rel_rot_tango;
        Rel_rot_err_vec = rotationMatrixToVector(Rel_rot_err_mat);
        
        if norm(Rel_rot_err_vec) > pi
            Rel_rot_err_vec = Rel_rot_err_vec.*(1-(2*pi/norm(Rel_rot_err_vec)));
        end
        
        y(error_counter:error_counter +2) = zeros(3,1);
        error_counter = error_counter + 3;
        
    end
%     error_counter
    %% Relative Translation Error
    
    y(error_counter:error_counter +2) = [0;0;0];
    error_counter = error_counter + 3;
    for i = 2:size(T,1)
        
        Rel_tra_var = R{i-1}'*(T(i,:)' - T(i-1,:)');
        Rel_tra_tango = R_tango{i-1}'*(T_tango(i,:)' - T_tango(i-1,:)');
        
        y(error_counter:error_counter +2) = Rel_tra_var - Rel_tra_tango ;
%         y(error_counter +2) = 0;
            
        error_counter = error_counter + 3;
        
    end
%     error_counter
    %% Absolute Rotation Error
%     size(con_ind,2)
    for i = 1:size(con_ind,2)
        
        Abs_rot_err_mat = R{con_ind(i)}'* rot_con_mat{con_anchor_no(i)};
        Abs_rot_err_vec = rotationMatrixToVector(Abs_rot_err_mat);
        
        if norm(Abs_rot_err_vec) > pi
            Abs_rot_err_vec = Abs_rot_err_vec.*(1-(2*pi/norm(Abs_rot_err_vec)));
        end
        
        
         y(error_counter:error_counter +2) = zeros(3,1);
%          y(error_counter:error_counter +2) = zeros(3,1);   
         error_counter = error_counter + 3;    
    
    end
%     error_counter
    %% Absolute Translation Error
    
    for i= 1:size(con_ind,2)
         y(error_counter:error_counter +2) = T(con_ind(i))' - tra_con(con_anchor_no(i))';
%          y(error_counter +2) = 0;
%             y(error_counter:error_counter +2) = zeros(3,1);
         error_counter = error_counter + 3;
    
    end
    
    
elseif mode == '3'
    %% Relative Rotation Error
    
    y(error_counter:error_counter +2) = [0;0;0];
    error_counter = error_counter + 3;
    for i = 2:size(T,1)
        
        Rel_rot_var = R{i-1}'*R{i};
        Rel_rot_tango = R_tango{i-1}'*R_tango{i};
        
        Rel_rot_err_mat = Rel_rot_var'*Rel_rot_tango;
        Rel_rot_err_vec = rotationMatrixToVector(Rel_rot_err_mat);
        
        if norm(Rel_rot_err_vec) > pi
            Rel_rot_err_vec = Rel_rot_err_vec.*(1-(2*pi/norm(Rel_rot_err_vec)));
        end
        
        y(error_counter:error_counter +2) = Rel_rot_err_vec;
        error_counter = error_counter + 3;
        
    end
%     error_counter
    %% Relative Translation Error
    
    y(error_counter:error_counter +2) = [0;0;0];
    error_counter = error_counter + 3;
    for i = 2:size(T,1)
        
        Rel_tra_var = R{i-1}'*(T(i,:)' - T(i-1,:)');
        Rel_tra_tango = R_tango{i-1}'*(T_tango(i,:)' - T_tango(i-1,:)');
        
        y(error_counter:error_counter +2) = Rel_tra_var - Rel_tra_tango ;
            
        error_counter = error_counter + 3;
        
    end
%     error_counter
    %% Absolute Rotation Error
%     size(con_ind,2)
    for i = 1:size(con_ind,2)
        
        Abs_rot_err_mat = R{con_ind(i)}'* rot_con_mat{con_anchor_no(i)};
        Abs_rot_err_vec = rotationMatrixToVector(Abs_rot_err_mat);
        
        if norm(Abs_rot_err_vec) > pi
            Abs_rot_err_vec = Abs_rot_err_vec.*(1-(2*pi/norm(Abs_rot_err_vec)));
        end
        
        
%          y(error_counter:error_counter +2) = Abs_rot_err_vec;
         y(error_counter:error_counter +2) = zeros(3,1);   
         error_counter = error_counter + 3;    
    
    end
%     error_counter
    %% Absolute Translation Error
    
    for i= 1:size(con_ind,2)
         y(error_counter:error_counter +2) = T(con_ind(i))' - tra_con(con_anchor_no(i))';
%             y(error_counter:error_counter +2) = zeros(3,1);
         error_counter = error_counter + 3;
    
    end

elseif mode == '4'
    %% Relative Rotation Error
    
    y(error_counter:error_counter +2) = [0;0;0];
    error_counter = error_counter + 3;
    for i = 2:size(T,1)
        
        Rel_rot_var = R{i-1}'*R{i};
        Rel_rot_tango = R_tango{i-1}'*R_tango{i};
        
        Rel_rot_err_mat = Rel_rot_var'*Rel_rot_tango;
        Rel_rot_err_vec = rotationMatrixToVector(Rel_rot_err_mat);
        
        if norm(Rel_rot_err_vec) > pi
            Rel_rot_err_vec = Rel_rot_err_vec.*(1-(2*pi/norm(Rel_rot_err_vec)));
        end
        
        y(error_counter:error_counter +2) = Rel_rot_err_vec;
        error_counter = error_counter + 3;
        
    end
%     error_counter
    %% Relative Translation Error
    
    y(error_counter:error_counter +2) = [0;0;0];
    error_counter = error_counter + 3;
    for i = 2:size(T,1)
        
        Rel_tra_var = R{i-1}'*(T(i,:)' - T(i-1,:)');
        Rel_tra_tango = R_tango{i-1}'*(T_tango(i,:)' - T_tango(i-1,:)');
        
        y(error_counter:error_counter +2) = Rel_tra_var - Rel_tra_tango ;
            
        error_counter = error_counter + 3;
        
    end
%     error_counter
    %% Absolute Rotation Error
%     size(con_ind,2)
    for i = 1:size(con_ind,2)
        
        Abs_rot_err_mat = R{con_ind(i)}'* rot_con_mat{con_anchor_no(i)};
        Abs_rot_err_vec = rotationMatrixToVector(Abs_rot_err_mat);
        
        if norm(Abs_rot_err_vec) > pi
            Abs_rot_err_vec = Abs_rot_err_vec.*(1-(2*pi/norm(Abs_rot_err_vec)));
        end
        
        
         y(error_counter:error_counter +2) = Abs_rot_err_vec;
%          y(error_counter:error_counter +2) = zeros(3,1);   
         error_counter = error_counter + 3;    
    
    end
%     error_counter
    %% Absolute Translation Error
    
    for i= 1:size(con_ind,2)
         y(error_counter:error_counter +2) = T(con_ind(i))' - tra_con(con_anchor_no(i))';
%             y(error_counter:error_counter +2) = zeros(3,1);
         error_counter = error_counter + 3;
    
    end
    
    
end

    %%
%     error_counter
    
%     
%     
%     parfor itr = 2:x_row
%         y(itr,:) = (x(itr,:) - x(itr - 1,:)) - (z(itr,:) - z(itr-1,:));
% 
%     end
%     
% 
%     [con_ind_row,con_ind_col] = size(con_ind);
%     parfor index = 1:con_ind_col
%         
%         y(x_row + index,:) = (x(con_ind(index),:) - con(con_anchor_no(index),:)) * 100;
% 
%         
%     end
%     
%     y = reshape(y,1,(x_row + con_ind_col)*2 );
% 
% end

