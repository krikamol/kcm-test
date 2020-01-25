function D = squaredist(x, z)
% a function to compute a matrix of pairwise square distance
% between two sets of vectors

% two sets of vectors are identical if only one is given
if nargin == 1 || isempty(z)
    z = x;
end

[d1, n] = size(x) ;
[d2, m] = size(z) ;

D = zeros(n,m) ;
for d = 1:d1
    D = D + (repmat(z(d,:),n,1) - repmat(x(d,:)',1,m)).^2 ;
end
