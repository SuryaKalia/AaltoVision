## Automated Dataset Generation
This tool is meant to simplify the process of creating indoor localization datasets using a Google Tango device for odometry and Point Clouds and iPhone for hi-res RGB images mounted together.

The implementation does not depend on any timestamp synchronization even though there are two independent devices involved. Instead, the user is required to visually identify one pair of image frames that appear to be representing the same time instant. This is very easily achieved by filming a countdown video at the beginning of the scene which helps in identifying one set of images corresponding to the same timestamp upto an accuracy of one frame.

### Requirements
* MATLAB
* ffmpeg
```
sudo add-apt-repository ppa:mc3man/trusty-media
sudo apt-get update
sudo apt-get install ffmpeg gstreamer0.10-ffmpeg
```
* ParaView Tango App (https://blog.kitware.com/paraview-and-project-tango-loading-data/)

### Deployment
* Specify the paths to Tango data, iPhone data and name of the video file in createDataset.m
* Run createDataset.m

**Inputs**: Folder with Tango Data as is provided by the ParaView app, hi-res video filmed by device mounted on the Tango device.

**Outputs**: Image frames extracted from video, .MAT file containing Point Clouds and Pose corresponding to each frame, .txt file containing image path info with translation and rotation vectors.
(Formats specified in code)

#### Customization
The input hi-res video format is .MOV for iPhone but any other video formats can be used too as long as it is supported by ffmpeg.

