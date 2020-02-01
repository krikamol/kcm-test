function [dec,tn,p,bvals] = smoothtest(Z,X,gres,theta,bsize,alpha)
%SMOOTHTEST: The smooth test with kernel nonparametric estimator.
%   
%   INPUT:  Z - vector of observations
%           X - subvector of Z
%           gres - vector-valued generalized residual function handle
%           theta - parameter value for gres function
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
d = size(X.mat,2);
if n ~= size(X.mat,1)
    % exit with an error message
    error("KCM: Z and X must have the same number of rows.");
end

% calculate the bandwidth parameter h and evaluate the kernel k
h = n^(-0.2);
D = squaredist(X.mat', X.mat');
K = exp(-D./h);

% evaluate the generalized residuals and the kernel h_theta
G = gres(Z,theta);
Ht = (G*G').*K;
Hu = Ht - diag(diag(Ht));

Ht2 = Ht.*Ht;
Hu2 = Ht2 - diag(diag(Ht2));

% calculate the smooth test statistic
vn = 2.*sum(sum(Hu2))/(n*(n-1)*(h^d));
tn = n*(h^(d/2))*sum(sum(Hu))/(n*(n-1)*(h^d)*sqrt(vn));

% approximate critical values via bootstrapping 
bvals = zeros(1,bsize);
for b=1:bsize
    
    % draw samples from standard normnal
    w = normrnd(0,1,[1,n]); 
    w2 = w.*w;
    
    % calculate bootstrap test statistic
    tns = (w*Hu*w')/(n*(n-1)*(h^d));
    vn = 2.*(w2*Hu2*w2')/(n*(n-1)*(h^d));
    bvals(b) = (n*(h^(d/2))*tns)/sqrt(vn);
    
end

% calculate the p-value using bootstrap statistics
p = mean(bvals >= tn);

% conduct the test
dec = 0;
if p < alpha
    dec = 1;
end

end

