% Author : Surya Kalia
% Summary: Synchronize iPhone image frames with the nearest (lesser) Tango's
% timestamp 

function [nearest_lesser] = create_split(tangoTimes,iPhoneTimes)

it = iPhoneTimes;
tt = tangoTimes;

nearest_lesser = zeros(size(it,1),1);


for i = 1:size(it,1)
     if it(i,1) <= tt(1,1)
            nearest_lesser(i,1) = -1;
    elseif it(i,1) > tt(1,1)
        for k = 1:size(tt,1)
            if it(i,1) < tt(k,1)
            nearest_lesser(i,1) = k-1;
            break;
            end
        end
     end
     
end
   
end
        
    
        