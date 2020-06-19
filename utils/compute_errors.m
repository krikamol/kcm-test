function [ pwr,err ] = compute_errors(h,ht)
%COMPUTE_ERRORS Calculate different types of errors
%   
%   INPOUT:
%       h - a vector of decisions
%       ht - a vector of true labels
%

pwr = 1.0-mean((ht == 1) & (h == 0));
err = mean((ht == 0) & (h == 1));

end
