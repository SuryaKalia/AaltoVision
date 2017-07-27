% Author: Surya Kalia
% Descripton: Constructs jacobian required by the lsqnonlin oprimizer. 

function J = constructJacobian_2( no_data, no_constraints, const_index , mode)
    
    J = zeros(6*no_data + 6*no_constraints, 6*no_data);

    
    if mode == '1'
        %Rel Rot Error
        for itr = 2:no_data
            start_index_vert = 3*(itr -1) +1;
%             J(start_index_vert:start_index_vert +2 , 3*no_data + itr -1 :3*no_data + itr) = ones(3,2);
%             J(start_index_vert:start_index_vert +2 , 4*no_data + itr -1 :4*no_data + itr) = ones(3,2);
%             J(start_index_vert:start_index_vert +2 , 5*no_data + itr -1 :5*no_data + itr) = ones(3,2);
        end

        %Rel Tra Error
        for itr = 2:no_data
            start_index_vert = 3*no_data +  3*(itr -1) +1;
            J(start_index_vert:start_index_vert +2 , itr -1 : itr) = ones(3,2);
            J(start_index_vert:start_index_vert +2 , no_data + itr -1 : no_data + itr) = ones(3,2);
%             J(start_index_vert:start_index_vert +2 , 2*no_data + itr -1 : 2*no_data + itr) = ones(3,2);
%             J(start_index_vert:start_index_vert +2 , 3*no_data + itr -1 ) = ones(3,1);
%             J(start_index_vert:start_index_vert +2 , 4*no_data + itr -1 ) = ones(3,1);
%             J(start_index_vert:start_index_vert +2 , 5*no_data + itr -1 ) = ones(3,1);  

        end 

        %Abs Rot Error
        for itr = 1:no_constraints
            start_index_vert = 6*no_data +  3*(itr -1) +1;
%             J(start_index_vert:start_index_vert +2 , 3*no_data + const_index(itr) ) = ones(3,1);
%             J(start_index_vert:start_index_vert +2 , 4*no_data + const_index(itr) ) = ones(3,1);
%             J(start_index_vert:start_index_vert +2 , 5*no_data + const_index(itr) ) = ones(3,1);    
        end

        %Abs Tra Error
        for itr = 1:no_constraints
            start_index_vert = 6*no_data + 3*no_constraints+  3*(itr -1) +1;
            J(start_index_vert, const_index(itr) ) = 1;
            J(start_index_vert +1, 1*no_data + const_index(itr) ) = 1;
%             J(start_index_vert +2, 2*no_data + const_index(itr) ) = 1;    
        end 
    
    
    elseif mode == '2'
        %Rel Rot Error
        for itr = 2:no_data
            start_index_vert = 3*(itr -1) +1;
%             J(start_index_vert:start_index_vert +2 , 3*no_data + itr -1 :3*no_data + itr) = ones(3,2);
%             J(start_index_vert:start_index_vert +2 , 4*no_data + itr -1 :4*no_data + itr) = ones(3,2);
%             J(start_index_vert:start_index_vert +2 , 5*no_data + itr -1 :5*no_data + itr) = ones(3,2);
        end

        %Rel Tra Error
        for itr = 2:no_data
            start_index_vert = 3*no_data +  3*(itr -1) +1;
            J(start_index_vert:start_index_vert +2 , itr -1 : itr) = ones(3,2);
            J(start_index_vert:start_index_vert +2 , no_data + itr -1 : no_data + itr) = ones(3,2);
            J(start_index_vert:start_index_vert +2 , 2*no_data + itr -1 : 2*no_data + itr) = ones(3,2);
%             J(start_index_vert:start_index_vert +2 , 3*no_data + itr -1 ) = ones(3,1);
%             J(start_index_vert:start_index_vert +2 , 4*no_data + itr -1 ) = ones(3,1);
%             J(start_index_vert:start_index_vert +2 , 5*no_data + itr -1 ) = ones(3,1);  

        end 

        %Abs Rot Error
        for itr = 1:no_constraints
            start_index_vert = 6*no_data +  3*(itr -1) +1;
%             J(start_index_vert:start_index_vert +2 , 3*no_data + const_index(itr) ) = ones(3,1);
%             J(start_index_vert:start_index_vert +2 , 4*no_data + const_index(itr) ) = ones(3,1);
%             J(start_index_vert:start_index_vert +2 , 5*no_data + const_index(itr) ) = ones(3,1);    
        end

        %Abs Tra Error
        for itr = 1:no_constraints
            start_index_vert = 6*no_data + 3*no_constraints+  3*(itr -1) +1;
            J(start_index_vert, const_index(itr) ) = 1;
            J(start_index_vert +1, 1*no_data + const_index(itr) ) = 1;
            J(start_index_vert +2, 2*no_data + const_index(itr) ) = 1;    
        end 
        
    elseif mode == '3'
        %Rel Rot Error
        for itr = 2:no_data
            start_index_vert = 3*(itr -1) +1;
            J(start_index_vert:start_index_vert +2 , 3*no_data + itr -1 :3*no_data + itr) = ones(3,2);
            J(start_index_vert:start_index_vert +2 , 4*no_data + itr -1 :4*no_data + itr) = ones(3,2);
            J(start_index_vert:start_index_vert +2 , 5*no_data + itr -1 :5*no_data + itr) = ones(3,2);
        end

        %Rel Tra Error
        for itr = 2:no_data
            start_index_vert = 3*no_data +  3*(itr -1) +1;
            J(start_index_vert:start_index_vert +2 , itr -1 : itr) = ones(3,2);
            J(start_index_vert:start_index_vert +2 , no_data + itr -1 : no_data + itr) = ones(3,2);
            J(start_index_vert:start_index_vert +2 , 2*no_data + itr -1 : 2*no_data + itr) = ones(3,2);
            J(start_index_vert:start_index_vert +2 , 3*no_data + itr -1 ) = ones(3,1);
            J(start_index_vert:start_index_vert +2 , 4*no_data + itr -1 ) = ones(3,1);
            J(start_index_vert:start_index_vert +2 , 5*no_data + itr -1 ) = ones(3,1);  

        end 

        %Abs Rot Error
        for itr = 1:no_constraints
            start_index_vert = 6*no_data +  3*(itr -1) +1;
%             J(start_index_vert:start_index_vert +2 , 3*no_data + const_index(itr) ) = ones(3,1);
%             J(start_index_vert:start_index_vert +2 , 4*no_data + const_index(itr) ) = ones(3,1);
%             J(start_index_vert:start_index_vert +2 , 5*no_data + const_index(itr) ) = ones(3,1);    
        end

        %Abs Tra Error
        for itr = 1:no_constraints
            start_index_vert = 6*no_data + 3*no_constraints+  3*(itr -1) +1;
            J(start_index_vert, const_index(itr) ) = 1;
            J(start_index_vert +1, 1*no_data + const_index(itr) ) = 1;
            J(start_index_vert +2, 2*no_data + const_index(itr) ) = 1;    
        end 
    
    elseif mode == '4'
        %Rel Rot Error
        for itr = 2:no_data
            start_index_vert = 3*(itr -1) +1;
            J(start_index_vert:start_index_vert +2 , 3*no_data + itr -1 :3*no_data + itr) = ones(3,2);
            J(start_index_vert:start_index_vert +2 , 4*no_data + itr -1 :4*no_data + itr) = ones(3,2);
            J(start_index_vert:start_index_vert +2 , 5*no_data + itr -1 :5*no_data + itr) = ones(3,2);
        end

        %Rel Tra Error
        for itr = 2:no_data
            start_index_vert = 3*no_data +  3*(itr -1) +1;
            J(start_index_vert:start_index_vert +2 , itr -1 : itr) = ones(3,2);
            J(start_index_vert:start_index_vert +2 , no_data + itr -1 : no_data + itr) = ones(3,2);
            J(start_index_vert:start_index_vert +2 , 2*no_data + itr -1 : 2*no_data + itr) = ones(3,2);
            J(start_index_vert:start_index_vert +2 , 3*no_data + itr -1 ) = ones(3,1);
            J(start_index_vert:start_index_vert +2 , 4*no_data + itr -1 ) = ones(3,1);
            J(start_index_vert:start_index_vert +2 , 5*no_data + itr -1 ) = ones(3,1);  

        end 

        %Abs Rot Error
        for itr = 1:no_constraints
            start_index_vert = 6*no_data +  3*(itr -1) +1;
            J(start_index_vert:start_index_vert +2 , 3*no_data + const_index(itr) ) = ones(3,1);
            J(start_index_vert:start_index_vert +2 , 4*no_data + const_index(itr) ) = ones(3,1);
            J(start_index_vert:start_index_vert +2 , 5*no_data + const_index(itr) ) = ones(3,1);    
        end

        %Abs Tra Error
        for itr = 1:no_constraints
            start_index_vert = 6*no_data + 3*no_constraints+  3*(itr -1) +1;
            J(start_index_vert, const_index(itr) ) = 1;
            J(start_index_vert +1, 1*no_data + const_index(itr) ) = 1;
            J(start_index_vert +2, 2*no_data + const_index(itr) ) = 1;    
        end 
        
    end


end


