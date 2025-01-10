function [] = inputMisalignment_dof5(misalignment)
%GETDATA 输出有失调量后的像差图像
%   此处显示详细说明
dx2 = misalignment(1);
dy2 = misalignment(2);
dz2 = misalignment(3);
tx2 = misalignment(4);
ty2 = misalignment(5);


cvcmd(['XDE S2 ' num2str(dx2)]);
cvcmd(['YDE S2 ' num2str(dy2)]);
cvcmd(['ZDE S2 ' num2str(dz2)]);
cvcmd(['ADE S2 ' num2str(tx2)]);
cvcmd(['BDE S2 ' num2str(ty2)]);


end

