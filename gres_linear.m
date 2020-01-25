function [ gvec ] = gres_linear(Z,theta)
%GRES_LINEAR The generalized residual function of a linear regression model.
%
%   INPUTS: Z=(X,Y) and parameter value theta=(theta_1,theta_2).
%   OUTPUTL gvec - the vector of generalized residuals

X = Z(1);
Y = Z(2);
n = length(Y);

gvec = Y - repmat(theta(1),n,1) - repmat(theta(2),n,1).*X;

end

