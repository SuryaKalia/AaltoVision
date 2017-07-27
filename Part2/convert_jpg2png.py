from PIL import Image
import glob, os
os.chdir("/l/Dependencies_l/Test/demon/examples/Tango_data_2loop")

file_ = open("image_list.txt", "w")

for itr in range (2596):
	for file in glob.glob("pc_20170529_123710_"+ str(itr).zfill(4)+"_*.jpg"):
		im = Image.open(file)
		im.save(file[:-3]+"png","PNG")
		file_.write(file[:-3]+"png\n")
		print(file)


file_.close()
# for file in glob.glob("pc_20170529_123710_2385_*.jpg"):
#     print(file)s