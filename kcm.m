function [mh,gm,dec] = kcm(Z,X,gres,theta,kern,bsize,alpha)
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
%   OUTPUT: mh - value of the test statistic
%           gm - (1-alpha)-quantile of the bootstrap statistics
%           dec - result of hypothesis testing (1: reject, 0: fail to reject)
%

% check the compatibility of data dimensions
n = size(Z,1);
if n ~= size(X,1)
    % exit with a warning message
end

% evaluate kernel matrix
sx = median_inter(X);
K = kern(X,X,sx);

% evaluate the kernel h 
G = gres(Z,theta);
H = (G*G').*K;

% evaluate the test statistic
mh = sum(sum(H))/(n*n) - sum(diag(H))/n;

% bootstrapping
bvals = zeros(1,bsize);
for b=1:bsize
    % draw multinomial random samples
    w = mnrnd(n,repmat(1./n,1,n)) - repmat(1./n,1,n);
    
    % calculate bootstrap test statistic
    WH = (w'*w).*H;
    mhs = sum(sum(WH)) - sum(diag(WH));
    
    % record the value
    bvals(b) = n*mhs;
    
end

% calculate the (1-\alpha)-quantile of the recorded statistics
gm = quantile(bval,1.-alpha);

% perform the test
dec = 0;
if gm < n*Mh
    dec = 1;
end


end

