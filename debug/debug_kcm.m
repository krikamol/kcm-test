%% debug the KCM test

addpath('../');
addpath('../utils/');

% initialize variables

dgp = "linreg_hom";
alpha = 0.05;
bsize = 1000;
n = 200;
delta = 0;
theta = [1.0,2.0];

[Z,X,gres] = generate_data(dgp,delta,n);
z = [Z.y, Z.x];
x = X.x;
[~,~,~,bvals] = kcm(z,x,gres,theta,@gaussrbf,bsize,alpha);

mhs = zeros(1,bsize);
for i=1:bsize
    [Z,X,gres] = generate_data(dgp,delta,n);
    z = [Z.y, Z.x];
    x = X.x;

    sx = sqrt(median_inter(x));
    K = gaussrbf(x,x,sx);

    % evaluate the generalized residuals and the kernel h_theta
    G = gres(z,theta);
    Ht = (G*G').*K;
    Hu = Ht - diag(diag(Ht));

    % calculate the KCM test statistic
    mhs(i) = sum(sum(Hu))/(n*(n-1));
end

% plot the histograms
h1 = histogram(bvals);
hold on
h2 = histogram(mhs);

