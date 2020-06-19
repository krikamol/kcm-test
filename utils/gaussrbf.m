function [K] = gaussrbf(X,Xt,varargin)
%GAUSSRBF The Gaussian RBF kernel function

if isempty(varargin)
    sig = 1.0;  % the default value of sigma
else
    sig = varargin{1};
end

D = squaredist(X',Xt',sig);
K = exp(-0.5.*D);

end

