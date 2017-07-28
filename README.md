# indoorLocalization
The project is intended to simplify the process of generation and correction of indoor localization datasets. Also included is a support tool for estimating relative pose using DeMoN using RGB image pairs from a given dataset.

## Contents
[**Part_1:**](https://github.com/AaltoVision/indoorLocalization/tree/master/Part1)
Floorplan tools - openCV based code to mark lables on the floorplan. Output is an edited png file with the marked labels and a text file with the correspinding coordinated on the map as well as the relative distances betwenn consecutive points in the ground frame. Also included is a tool for plotting camera centres on the floorplan image for better visualization.

[**Part_2:**](https://github.com/AaltoVision/indoorLocalization/tree/master/Part2)
Relative Pose estimation - Using DeMoN: Depth and Motion Network for Learning Monocular Stereo (https://arxiv.org/abs/1612.02401) to estimate relative pose between pairs of RGB (png) images only. The output is a binary file containing the estimated rotation and translation vectors. Format <rotation-quaternion (real x y z)> <translation 3D>

[**Part_3:**](https://github.com/AaltoVision/indoorLocalization/tree/master/Part3)
Automated Dataset Generation - This tool is meant to simplify the process of creating indoor localization datasets using a Google Tango device for odometry and Point Clouds and iPhone for hi-res RGB images mounted together.

[**Part_4:**](https://github.com/AaltoVision/indoorLocalization/tree/master/Par4)
Odometry Correction - For correcting the raw Tango odometry using Pose Graph optimization for loop closure. Anchor points are chosen from the floorplan (Part_1) which serve as absolute Ground truths for correcting the complete path.
