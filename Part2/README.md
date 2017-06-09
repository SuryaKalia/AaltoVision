This code was used to test DeMoN on RGB-D Dataset 7-Scenes (https://www.microsoft.com/en-us/research/project/rgb-d-dataset-7-scenes/)
The default example in original repo gives a depthmap png file as output. For greater usability it is modified to output the rotation and translation vecors between the given image pairs

To use this code:
1. Install DeMoN (https://github.com/lmb-freiburg/demon)
2. Merge these files with demon/examples/
3. Extract 7 Scenes dataset to the same directory with the scene directories labelled from 0 to 6.
  (eg. of a file in directory : /demon/examples/0/seq-02/frame-000000.color.png)
4. The input pairs are specified in NN_test_pairs.txt
5. run python3 example_edit.py

Output is a 7*1 vector containing the quaternion (format - real, x, y, z) and the translation vector (x, y, z) 
