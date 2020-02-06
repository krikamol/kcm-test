%% debug the smooth test

addpath('../');
addpath('../utils/');

% initialize variables
dgp = "linreg_hom";
alpha = 0.05;
bsize = 1000;
n = 1000;
d = 10;
delta = 0;
theta = ones([1,d+1]);

[Z,X,gres] = generate_data(dgp,delta,n,d);
%theta = estimate_parameters(dgp,Z);
[~,~,~,bvals] = smoothtest(Z,X,gres,theta,bsize,alpha);

mhs = zeros(1,bsize);
for i=1:bsize
    
    [Z,X,gres] = generate_data(dgp,delta,n,d);

    %theta = estimate_parameters(dgp,Z);
    
    % calculate the bandwidth parameter h and evaluate the kernel k
    h = d*(n^(-0.2));
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
    mhs(i) = n*(h^(d/2))*sum(sum(Hu))/(n*(n-1)*(h^d)*sqrt(vn));
    
end

% plot the histograms
h1 = histogram(bvals);
hold on
h2 = histogram(mhs);

