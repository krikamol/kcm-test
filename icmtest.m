function [dec,cn,p,bvals] = icmtest( Z,X,gres,theta,bsize,alpha)
%ICMTEST: The integrated conditional moment (ICM) test.
%   
%   INPUT:  Z - vector of observations
%           X - subvector of Z
%           gres - vector-valued generalized residual function handle
%           theta - parameter value for gres function
%           bsize - bootstrap sample size
%           alpha - significance level
%
%   OUTPUT: dec - result of hypothesis testing (1: reject, 0: fail to reject)
%           cn - value of the test statistic
%           p - the p-value
%           bvals - a vector of bootstrap statistics
%

% check the compatibility of data dimensions
n = size(Z.mat,1);
d = size(X.mat,2);
if n ~= size(X.mat,1)
    % exit with an error message
    error("KCM: Z and X must have the same number of rows.");
end

% define the indicator function
indfun = @(x,y) prod(x <= y);

% evaluate the generalized residuals and the kernel h_theta
G = gres(Z,theta);
Rn = @(x) sum(G(bsxfun(@indfun,X.mat,x),:),1)/n; 

% calculate the ICM test statistic
cn = 0;
for i=1:n
    cn = cn + Rn(X.mat(i,:))'*Rn(X.mat(i,:));
end

% approximate critical values via bootstrapping 
bvals = zeros(1,bsize);
for b=1:bsize
    
    % calculate bootstrap test statistic
    % bvals(b) = ?
    
end

% calculate the p-value using bootstrap statistics
p = mean(bvals >= cn);

% conduct the test
dec = 0;
if p < alpha
    dec = 1;
end

end

