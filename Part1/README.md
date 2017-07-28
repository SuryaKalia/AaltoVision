# Floor plan Tools
These tools provide the interface between the actual floor plan and Odometry data.

## Usage

### label.py
The first step in dataset creation is marking points on the floorplan which would be anchor points for subsequent dataset correction.

**Input:** jpg file of floor plan. Path specified in code.

**Output:** "marked.jpg" file with chosen points labelled and marked on the floorplan. "coordinates.txt" file with pixel coordinates (y,x) and ground distance in metres between the given point and successive labelled point.

![Alt text](https://github.com/AaltoVision/indoorLocalization/blob/master/Part1/label_animation.gif)

* Input image is set to be Floor 3 of the CS building in the default code.
* In the GUI, panning is using the scroll bars at the top. Zooming is by right click drag up/down.
* Left click marks the label points on the map
* ESC - to exit without saving
* s - to save and exit

### plot_overlap.py
The last step after creating the dataset is to visualise the camera centre trajectory on the floorplan to check its correspondence to the intended trajectory. 

**Input:** MAT file(s) of the dataset odometry. (Format of *University* dataset). jpg image of floor plan.

**Output:** jpg file of floorplan with camera centre trajectories superimposed.

[[https://github.com/AaltoVision/indoorLocalization/blob/master/Part1/plot_overlap_image.jpg]]
