function [K] = gaussrbf(X,Xt,varargin)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

if isempty(varargin)
    sig = 1.0;  % the default value of sigma
else
    sig = varargin{1};
end

D = squaredist(X',Xt',sig);
K = exp(-0.5.*D);

end

