function [ gvec ] = gres_linear(Z,theta)
%GRES_LINEAR The generalized residual function of a linear regression model.
%
%   INPUTS: Z=(X,Y) and parameter value theta=(theta_1,theta_2).
%   OUTPUTL gvec - the vector of generalized residuals

y = Z.y;
x = Z.x;

gvec = y - theta(1) - x*theta(2:end)';

end

