function [ gvec ] = gres_simultaneous(Z,theta)
%GRES_SIMULTANEOUS The generalized residual function of the simultaneous
%                   equation model.

q = Z(:,1);
p = Z(:,2);
r = Z(:,3);
w = Z(:,4);

gvec = [q - theta(1).*p - theta(2).*r, q - theta(3).*p - theta(4).*w];

end