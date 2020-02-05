function [dec,mh,p,bvals] = kcm(Z,X,gres,theta,kern,bsize,alpha)
%KCM: The kernel conditional moment (KCM) test.
%   
%   INPUT:  Z - vector of observations
%           X - subvector of Z
%           gres - vector-valued generalized residual function handle
%           theta - parameter value for gres function
%           kern - positive definite kernel function handle
%           bsize - bootstrap sample size
%           alpha - significance level
%
%   OUTPUT: dec - result of hypothesis testing (1: reject, 0: fail to reject)
%           mh - value of the test statistic
%           p - the p-value
%           bvals - a vector of bootstrap statistics
%

% check the compatibility of data dimensions
n = size(Z.mat,1);
if n ~= size(X.mat,1)
    % exit with an error message
    error("KCM: Z and X must have the same number of rows.");
end

% calculate the median distance of X and evaluate the kernel k
sx = sqrt(median_inter(X.mat)/2);
K = kern(X.mat,X.mat,sx);

% evaluate the generalized residuals and the kernel h_theta
G = gres(Z,theta);
Ht = (G*G').*K;
Hu = Ht - diag(diag(Ht));

% calculate the KCM test statistic
mh = sum(sum(Hu))/(n*(n-1));

% approximate critical values via bootstrapping 
bvals = zeros(1,bsize);
for b=1:bsize
    
    % draw multinomial random samples
    w = mnrnd(n,ones(1,n)/n)/n; 
    
    % calculate bootstrap test statistic
    bvals(b) = (w-1/n)*Hu*(w'-1/n);
    
end

% calculate the p-value using bootstrap statistics
p = mean(bvals >= mh);

% conduct the test
dec = 0;
if p < alpha
    dec = 1;
end

end

