% by Juho Kannala
%Vector form of rotation to matrix form (Rodriguez formula)
function R=rotationVectorToMatrix(t)

    axang = [t./norm(t) norm(t)];
    R = axang2rotm(axang);

