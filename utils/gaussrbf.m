function [K] = gaussrbf(X,Xt,varargin)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

if isempty(varargin)
    sig = 1;  % the default value of sigma
else
    sig = varargin{1};
end

D = squaredist(X', Xt');
K = exp(-0.5.*D./(sig^2));

end

