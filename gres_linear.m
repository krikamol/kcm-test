function [ gvec ] = gres_linear(Z,theta)
%GRES_LINEAR The generalized residual function of a linear regression model.
%
%   INPUTS: Z=(X,Y) and parameter value theta=(theta_1,theta_2).
%   OUTPUTL gvec - the vector of generalized residuals

y = Z(:,1);
x = Z(:,2);

gvec = y - theta(1) - theta(2).*x;

end

