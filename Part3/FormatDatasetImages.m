% Author: Surya Kalia

function [] = FormatDatasetImages(folder, first_img, last_img, tot_img)
curr_directory = pwd;

cd(folder);

for i = 1:first_img -1
    system(['rm frame--' sprintf('%0.5d', i) '.png']);
end

for i = last_img +1 : tot_img
    system(['rm frame--' sprintf('%0.5d', i) '.png']);
end


system(['rename ''s/.+/our $i; sprintf("frame_%05d.png", 1+$i++)/e'' * '])

cd(curr_directory);

end

