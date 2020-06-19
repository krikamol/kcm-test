function [ gvec ] = gres_simultaneous(Z,theta)
%GRES_SIMULTANEOUS The generalized residual function of the simultaneous
%                   equation model.

q = Z.q; % quantity
p = Z.p; % price
r = Z.r; % exogeneous var
w = Z.w; % exogeneous var

gvec = [q - theta(1).*p - theta(2).*r, q - theta(3).*p - theta(4).*w];

end
