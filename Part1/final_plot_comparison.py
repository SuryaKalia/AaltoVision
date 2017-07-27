import matplotlib.pyplot as plt
import scipy.io
import numpy as np

img = plt.imread("floor3_med.jpg")
fig, ax = plt.subplots()
ax.imshow(img)


original = scipy.io.loadmat('Office_seq_01.mat')
# reconstructed = scipy.io.loadmat('reconstructed.mat')
original2 = scipy.io.loadmat('Kitchen1_seq_01.mat')
original3 = scipy.io.loadmat('Conference_seq_01.mat')
original4 = scipy.io.loadmat('Meeting_seq_01.mat')
original5 = scipy.io.loadmat('Kitchen2_seq_01.mat')
original6 = scipy.io.loadmat('reconstructed.mat')
original7 = scipy.io.loadmat('Office_seq_03.mat')


o_array  = original['iPhonePose']
o_array2  = original2['iPhonePose']
o_array3  = original3['iPhonePose']
o_array4  = original4['iPhonePose']
o_array5  = original5['iPhonePose']
o_array6  = original6['reconstructed']
o_array7  = original7['iPhonePose']

num_points = o_array.size
num_points2 = o_array2.size
num_points3 = o_array3.size
num_points4 = o_array4.size
num_points5 = o_array5.size
(num_points6,temp) = o_array6.shape
num_points7 = o_array7.size

coord = np.zeros((num_points,2))
coord2 = np.zeros((num_points2,2))
coord3 = np.zeros((num_points3,2))
coord4 = np.zeros((num_points4,2))
coord5 = np.zeros((num_points5,2))
coord6 = np.zeros((num_points6,2))
coord7 = np.zeros((num_points7,2))

for i in range(0,num_points):
	coord[i] = o_array[i][0][0:2,3]

for i in range(0,num_points2):
	coord2[i] = o_array2[i][0][0:2,3]

for i in range(0,num_points3):
	coord3[i] = o_array3[i][0][0:2,3]

for i in range(0,num_points4):
	coord4[i] = o_array4[i][0][0:2,3]

for i in range(0,num_points5):
	coord5[i] = o_array5[i][0][0:2,3]

coord6 = o_array6

for i in range(0,num_points7):
	coord7[i] = o_array7[i][0][0:2,3]

plt_coord = coord / 0.033917
plt_coord2 = coord2 / 0.033917
plt_coord3 = coord3 / 0.033917
plt_coord4 = coord4 / 0.033917
plt_coord5 = coord5 / 0.033917
plt_coord6 = coord6 / 0.033917
plt_coord7 = coord7 / 0.033917

switch_axes = np.array([[ -1, 1] ]*num_points)
switch_axes2 = np.array([[ -1, 1] ]*num_points2)
switch_axes3 = np.array([[ -1, 1] ]*num_points3)
switch_axes4 = np.array([[ -1, 1] ]*num_points4)
switch_axes5 = np.array([[ -1, 1] ]*num_points5)
switch_axes6 = np.array([[ -1, 1] ]*num_points6)
switch_axes7 = np.array([[ -1, 1] ]*num_points7)

plt_coord = plt_coord * switch_axes
plt_coord2 = plt_coord2 * switch_axes2
plt_coord3 = plt_coord3 * switch_axes3
plt_coord4 = plt_coord4 * switch_axes4
plt_coord5 = plt_coord5 * switch_axes5
plt_coord6 = plt_coord6 * switch_axes6
plt_coord7 = plt_coord7 * switch_axes7

origin = np.array([[ 2324, 747] ]*num_points)
origin2 = np.array([[ 2324, 747] ]*num_points2)
origin3 = np.array([[ 2324, 747] ]*num_points3)
origin4 = np.array([[ 2324, 747] ]*num_points4)
origin5 = np.array([[ 2324, 747] ]*num_points5)
origin6 = np.array([[ 2324, 747] ]*num_points6)
origin7 = np.array([[ 2324, 747] ]*num_points7)

plt_coord = plt_coord + origin
plt_coord2 = plt_coord2 + origin2
plt_coord3 = plt_coord3 + origin3
plt_coord4 = plt_coord4 + origin4
plt_coord5 = plt_coord5 + origin5
plt_coord6 = plt_coord6 + origin6
plt_coord7 = plt_coord7 + origin7

# plt_coord_x = [int(row[0]) for row in plt_coord]
# plt_coord_y = [int(row[1]) for row in plt_coord]

plt_coord_x = [2* (row[0] - 40) for row in plt_coord]
plt_coord_y = [2* (row[1] + 40) for row in plt_coord]

plt_coord_x2 = [2*(row[0] - 40) for row in plt_coord2]
plt_coord_y2 = [2*(row[1] + 40) for row in plt_coord2]

plt_coord_x3 = [2*(row[0] - 40) for row in plt_coord3]
plt_coord_y3 = [2*(row[1] + 85) for row in plt_coord3]

plt_coord_x4 = [2*(row[0] - 10) for row in plt_coord4]
plt_coord_y4 = [2*(row[1] + 65) for row in plt_coord4]

plt_coord_x5 = [2*(row[0] + 15) for row in plt_coord5]
plt_coord_y5 = [2*(row[1] + 65) for row in plt_coord5]

plt_coord_x6 = [2*(row[0])  for row in plt_coord6]
plt_coord_y6 = [2*(row[1])  for row in plt_coord6]

plt_coord_x7 = [2*(row[0]) - 65 for row in plt_coord7]
plt_coord_y7 = [2*(row[1]) + 65 for row in plt_coord7]

# print plt_coord_x


plt.scatter(x = plt_coord_x , y = plt_coord_y, color ='r', s=4)
plt.scatter(x = plt_coord_x2 , y = plt_coord_y2, color ='r', s=4)
plt.scatter(x = plt_coord_x3 , y = plt_coord_y3, color ='r', s=4)
plt.scatter(x = plt_coord_x4 , y = plt_coord_y4, color ='r', s=4)
plt.scatter(x = plt_coord_x5 , y = plt_coord_y5, color ='r', s=4)
plt.scatter(x = plt_coord_x6 , y = plt_coord_y6, color ='b', s=4)
plt.scatter(x = plt_coord_x7 , y = plt_coord_y7, color ='g', s=4)







plt.show()
 # o_array[i][0][0:2,3]
# print (o_array[1][1,1]).size

# o_array = original['original']
# # r_array = reconstructed['reconstructed']

# plt_o_array = o_array / 0.033917
# # plt_r_array = r_array / 0.033917

# switch_axes = np.array([[ -1, 1] ]*1240)

# plt_o_array = plt_o_array * switch_axes
# # plt_r_array = plt_r_array * switch_axes


# origin = np.array([[ 2324, 747] ]*1240)

# plt_o_array =  plt_o_array + origin
# # plt_r_array =  plt_r_array + origin

# plt_o_array_x = [int(row[0]) for row in plt_o_array]
# plt_o_array_y = [int(row[1]) for row in plt_o_array]
# # plt_r_array_x = [int(row[0]) for row in plt_r_array]
# # plt_r_array_y = [int(row[1]) for row in plt_r_array]


# print plt_o_array_x
# print plt_o_array_y

# # plt.figure(figsize=(4000,4000))
# # plt.scatter(x = plt_o_array_x , y = plt_o_array_y,  c='r', s=4)
# plt.scatter(x = plt_r_array_x , y = plt_r_array_y, s=1)

# # plt.scatter(x=[30, 40], y=[50, 60], c='r', s=40)

# plt.show()