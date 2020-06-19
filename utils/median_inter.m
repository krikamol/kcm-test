function [ mdx ] = median_inter(X)
%MEDIAN_INTER This function efficiently calculates the median heuristic

[n,d] = size(X);

% subsample if sample size is too large
if n>100
    Xs = X(randperm(n,100),:);
    n = 100;
else
    Xs = X;
end

% find median distance along each dimension
mdx = zeros(1,d);
for i=1:d
    G = sum((Xs(:,i).*Xs(:,i)),2);
    Q = repmat(G,1,n);
    R = repmat(G',n,1);
    dists = Q + R - 2*(Xs(:,i)*Xs(:,i)');
    dists = dists-tril(dists);
    dists = reshape(dists,n^2,1);
    mdx(i) = median(dists(dists>0));
end

end

