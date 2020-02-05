function D = squaredist(x,z,varargin)
% a function to compute a matrix of pairwise square distance
% between two sets of vectors

% two sets of vectors are identical if only one is given
if nargin == 1 || isempty(z)
    z = x;
end

[dx, n] = size(x) ;
[~, m] = size(z) ;

% weights
if isempty(varargin)
    s = ones(dx,1);
else
    if isscalar(varargin{1})
        s = varargin{1}.*ones(dx,1);
    else
        s = varargin{1};
    end
end
    
D = zeros(n,m) ;
for d = 1:dx
    D = D + (repmat(z(d,:),n,1) - repmat(x(d,:)',1,m)).^2./(s(d).^2);
end
