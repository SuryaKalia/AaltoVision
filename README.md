# indoorLocalization
The project is intended to simplify the process of generation and correction of indoor localization datasets. Also included is a support tool for estimating relative pose using DeMoN using RGB image pairs from a given dataset.

## Contents
Part_1: Floorplan tools - openCV based code to mark lables on the floorplan. Output is an edited png file with the marked labels and a text file with the correspinding coordinated on the map as well as the relative distances betwenn consecutive points in the ground frame. Also included is a tool for plotting camera centres on the floorplan image for better visualization.

Part_2: Depth Map Generation - Using DeMoN: Depth and Motion Network for Learning Monocular Stereo (https://arxiv.org/abs/1612.02401) to estimate relative pose between pairs of RGB (png) images only. The output is a binary file containing the estimated rotation and translation vectors. Format <rotation-quaternion (real x y z)> <translation 3D>

Part_3: 

