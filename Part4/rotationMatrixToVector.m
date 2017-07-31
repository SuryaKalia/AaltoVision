% by Juho Kannala
%Matrix form of rotation to vector form (Rodriguez formula)
function t=rotationMatrixtoVector(R)

angax = rotm2axang(R);
t(1:3) = angax(4).*angax(1:3);
