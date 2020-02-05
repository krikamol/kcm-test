%% debug the ICM test

addpath('../');
addpath('../utils/');

% initialize variables

dgp = "linreg_hom";
alpha = 0.05;
bsize = 200;
n = 200;
d = 1;
delta = 0;
theta = ones([1,d+1]);

[Z,X,gres] = generate_data(dgp,delta,n,d);
%theta = estimate_parameters(dgp,Z);
[~,~,~,bvals] = icmtest(Z,X,gres,@icm_grad_linear,@icm_loss_linear,theta,bsize,alpha);

cns = zeros(1,bsize);
for i=1:bsize
    [Z,X,gres] = generate_data(dgp,delta,n,d);
    z = [Z.y, Z.x];
    x = X.x;
    
    %theta = estimate_parameters(dgp,Z);
    
    % evaluate the generalized residuals and the kernel h_theta
    G = gres(Z,theta);
    Rn = @(y) sum(G(logical(prod(bsxfun(@le,X.mat,y),2)),:),1)/n; 
    
    % calculate the ICM test statistic
    for j=1:n
        Rvec = Rn(X.mat(j,:));
        cns(i) = cns(i) + Rvec'*Rvec;
    end
end

% plot the histograms
h1 = histogram(bvals);
hold on
h2 = histogram(cns);

