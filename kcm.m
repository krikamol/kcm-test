function [dec,mh,gm,bvals] = kcm(Z,X,gres,theta,kern,bsize,alpha)
%KCM: The kernel conditional moment (KCM) test. 
%   
%   INPUT:  Z - vector of observations
%           X - subvector of Z
%           gres - vector-valued generalized residual function
%           theta - parameter value for gres function
%           kern - positive definite kernel function
%           bsize - bootstrap sample size
%           alpha - significance level
%
%   OUTPUT: dec - result of hypothesis testing (1: reject, 0: fail to reject)
%           mh - value of the test statistic
%           gm - (1-alpha)-quantile of the bootstrap statistics
%           bvals - a vector of bootstrap statistics
%

% check the compatibility of data dimensions
n = size(Z,1);
if n ~= size(X,1)
    % exit with an error message
    error("KCM: Z and X must have the same number of rows.");
end

% calculate the median distance of X and evaluate the kernel k
sx = median_inter(X);
K = kern(X,X,sx);

% evaluate the generalized residuals and the kernel h_theta
G = gres(Z,theta);
H = (G*G').*K;

% calculate the KCM test statistic
mh = sum(sum(H))/(n*n) - sum(diag(H))/n;

% approximate critical values via bootstrapping 
bvals = zeros(1,bsize);
for b=1:bsize
    % draw multinomial random samples
    w = mnrnd(n,repmat(1./n,1,n)) - repmat(1./n,1,n);
    
    % calculate bootstrap test statistic
    WH = (w'*w).*H;
    mhs = sum(sum(WH)) - sum(diag(WH));
    
    % record the bootstrap value
    bvals(b) = n*mhs;
end

% calculate the (1-alpha)-quantile of the bootstrap statistics
gm = quantile(bvals,1.-alpha);

% conduct the test
dec = 0;
if gm < n*Mh
    dec = 1;
end


end

