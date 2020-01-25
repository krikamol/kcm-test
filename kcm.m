function [MH,GM,DEC] = kcm(Z,X,gres,theta,kern,bsize,alpha)
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
%   OUTPUT: MH - value of the test statistic
%           GM - (1-alpha)-quantile of the bootstrap statistics
%           DEC - result of hypothesis testing (1: reject, 0: fail to reject)
%

% check the compatibility of data dimensions
n = size(Z,1);
if n ~= size(X,1)
    % exit with a warning message
end

% evaluate kernel matrix

% evaluate the kernel h 

% evaluate the test statistic

% bootstrapping
bvals = zeros(1,bsize);
for b=1:bsize
    % draw sample from Multinomial
    w = mnrnd(n,repmat(1./n,1,n));
    
    % calculate bootstrap test statistic
    Mhs = ...
    
    % record the value
    bvals[b] = n*Mhs;
    
end

% calculate the (1-\alpha)-quantile of the recorded statistics
GM = quantile(bval,1-alpha);

% perform the test
DEC = ...

end

