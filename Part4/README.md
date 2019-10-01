# Odometry Correction 
For correcting the raw Tango odometry using Pose Graph optimization for loop closure. Anchor points are chosen from the floorplan ([Part_1](https://github.com/SuryaKalia/AaltoVision/tree/master/Part1)) which serve as absolute Ground truths for correcting the complete path.

The few absolute ground truth points are used for correcting the open loops. Preferably the dataset must have repeated instances of the same anchor point for better correction.
Translation ground truths are easily obtained by PART_1 but Orientation ground truths need to be calculated manually by calculating the slopes of the pose normals with respect to the floor plan.

## Usage
Specify the required directory paths in try_optimization.m 

```
>> try_optimization
```
4 different optimization options are provided:
  1. *Only translation optimization(without z)* - Assumes all camera centres to lie on same horizontal plane. Ideal if only single floor/elevation is in dataset. (5 Dof)
  
   2. *Only translation optimization(with z)* - Uses 'z' coordinate for correction too. Increases computation, but necessary if multiple elevations are involved.
  
  3. *Both rot+trans without absolute rotation constraint* - Pose graph optimization uses only relative rot+trans and absolute translation terms in cost function and Jacobian. This is better than complete optimization as the absolute rotation values (3 Dof)  are usually error prone, but the relative rotation between anchor points is not.
  
  4. *Complete Optimization* - Both absolute and relative rotation and translation constraints applied.

### Uncorrected point cloud: 
![Uncorrected](https://github.com/SuryaKalia/AaltoVision/blob/master/Part4/uncorrected.jpg)

### Corrected point cloud:
![Corrected](https://github.com/SuryaKalia/AaltoVision/blob/master/Part4/corrected.jpg)
(Colouring gradient misinterpreted by plotting function)
