%% debug the KCM test

addpath('../');
addpath('../utils/');

% initialize variables

dgp = "linreg_hom";
alpha = 0.05;
bsize = 1000;
n = 500;
d = 10;
delta = 0;
theta = ones([1,d+1]);

[Z,X,gres] = generate_data(dgp,delta,n,d);
%theta = estimate_parameters(dgp,Z);
[~,~,~,bvals] = kcm(Z,X,gres,theta,@gaussrbf,bsize,alpha);

mhs = zeros(1,bsize);
for i=1:bsize
    [Z,X,gres] = generate_data(dgp,delta,n,d);
    z = [Z.y, Z.x];
    x = X.x;
    
    %theta = estimate_parameters(dgp,Z);
    
    sx = sqrt(median_inter(x));
    K = gaussrbf(x,x,sx);

    % evaluate the generalized residuals and the kernel h_theta
    G = gres(Z,theta);
    Ht = (G*G').*K;
    Hu = Ht - diag(diag(Ht));

    % calculate the KCM test statistic
    mhs(i) = sum(sum(Hu))/(n*(n-1));
end

% plot the histograms
h1 = histogram(bvals);
hold on
h2 = histogram(mhs);

