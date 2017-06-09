# indoorLocalization

This is currently under construction.

Part - 1: Dataset creation - openCV based code to mark lables on the floorplan. Output is an edited png file with the marked labels and a text file with the correspinding coordinated on the map as well as the relative distances betwenn consecutive points in the ground frame.

Part - 2: Depth Map Generation - Using DeMoN: Depth and Motion Network for Learning Monocular Stereo (https://arxiv.org/abs/1612.02401) to generate depth maps from pairs of png images only. The output is a binary file containing the estimated rotation and translation vectors. Format <rotation-quaternion (real x y z)> <translation>
