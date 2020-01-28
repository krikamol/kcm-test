function [ mdx ] = median_inter(X)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

n = size(X,1);
A = repmat(X,1,n);
B = A';
dist = abs(A-B);
dist = reshape(dist,[],1);
mdx = median(dist);

%mdx = median(squareform(squaredist(X)));

end

