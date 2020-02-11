%% debug the icm_simple test

addpath('../');
addpath('../utils/');

% initialize variables

dgp = "linreg_hom";
alpha = 0.05;
bsize = 1000;
n = 500;
d = 3;
delta = 0;
theta = ones([1,d+1]);

[Z,X,gres] = generate_data(dgp,delta,n,d);
%theta = estimate_parameters(dgp,Z);
[~,~,~,bvals] = icmtest_simple(Z,X,gres,@icm_grad_linear,@icm_loss_linear,theta,bsize,alpha);

cns = zeros(1,bsize);
for i=1:bsize
    
    [Z,X,gres] = generate_data(dgp,delta,n,d);
    z = [Z.y, Z.x];
    x = X.x;
    
    %theta = estimate_parameters(dgp,Z);
        
    % evaluate the generalized residuals and the kernel h_theta
    G = gres(Z,theta);
    I = zeros(n,n);
    for j=1:n
        I(:,j) = prod(bsxfun(@le,X.mat,X.mat(j,:)),2);
    end    

    % calculate the ICM test statistic
    Rn = (I'*G)./n;
    Rn2 = Rn.^2;
    cns(i) = sum(sum(Rn2,2));

end

% plot the histograms
h1 = histogram(bvals,'Normalization','probability'); hold on
h2 = histogram(cns,'Normalization','probability');

