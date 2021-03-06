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
I = zeros(n,n);
for i=1:n
    I(:,i) = prod(bsxfun(@le,X.mat,X.mat(i,:)),2);
end    

% calculate the ICM test statistic
Rn = (I'*G)./n;
Rn2 = Rn.^2;
cn = sum(sum(Rn2,2));

% approximate critical values via bootstrapping 
q  = size(G,2);
dG = grad(Z,theta);
L  = lfun(Z,theta);

dGI = (I'*dG)./n;

ri = zeros(n,n,q);
for i=1:n
    for j=1:n
        if prod(X.mat(i,:) <= X.mat(j,:))
            ri(i,j,:) = G(i,:) + dGI(j,:)*L(i,:,:)';
        else
            ri(i,j,:) = dGI(j,:)*L(i,:,:)';
        end
    end
end

bvals = zeros(1,bsize);
for b=1:bsize
    
    % draw samples from standard normnal
    w = normrnd(0,1,[n,1]);

    % calculate bootstrap test statistic
    Rns = zeros(n,q);
    for j=1:n
        Rns(j,:) = sum(ri(:,j,:).*repmat(w,1,q),1)./n; % careful about the sum dimension
    end
    
    Rns2 = Rns.^2;
    bvals(b) = sum(sum(Rns2,2));

end

% calculate the p-value using bootstrap statistics
p = mean(bvals >= cn);

% conduct the test
dec = 0;
if p < alpha
    dec = 1;
end

end

