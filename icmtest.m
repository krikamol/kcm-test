function [dec,cn,p,bvals] = icmtest( Z,X,gres,grad,lfun,theta,bsize,alpha)
%ICMTEST: The integrated conditional moment (ICM) test.
%   
%   INPUT:  Z - vector of observations
%           X - subvector of Z
%           gres - vector-valued generalized residual function handle
%           grad - gradient of generalized residual function
%           lfun - auxiliary loss function
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
if n ~= size(X.mat,1)
    % exit with an error message
    error("KCM: Z and X must have the same number of rows.");
end

% evaluate the generalized residuals and the kernel h_theta
G = gres(Z,theta);
Rn = @(x) sum(G(logical(prod(bsxfun(@le,X.mat,x),2)),:),1)/n; 

% calculate the ICM test statistic
cn = 0;
for i=1:n
    Rvec = Rn(X.mat(i,:));
    cn = cn + Rvec'*Rvec;
end

% approximate critical values via bootstrapping 
q = size(G,2);
dG = grad(Z,theta);
Rsni = @(x,lz) G(logical(prod(bsxfun(@le,X.mat,x),2)),:) + (sum(dG(logical(prod(bsxfun(@le,X.mat,x),2)),:,:),1)/n)*lz;

bvals = zeros(1,bsize);
for b=1:bsize
    
    % draw samples from standard normnal
    w = normrnd(0,1,[n,1]);
    
    % calculate bootstrap test statistic
    Rns = zeros(n,q);
    for i=1:n
        Rns(i,:) = Rns(i,:) + (Rsni(X.mat(i,:),lfun(Z.mat(i,:),theta))*w(i));
    end
    Rns = Rns./n;
    
    cns = 0;
    for i=1:n
        cns = cns + Rns(i,:)*Rns(i,:)';
    end

    bvals(b) = cns;
    
end

% calculate the p-value using bootstrap statistics
p = mean(bvals >= cn);

% conduct the test
dec = 0;
if p < alpha
    dec = 1;
end

end

