%% Labor market experiment

addpath('/utils');

% initialization
rng(99);

alpha = 0.05;
bsize = 1000;

tests = {'kcm','icm','smooth'};

% load and preprocess the data

% Y: wage, Xs: dependent variables
[Z,X,~] = generate_data('linreg_hom',0.01,200,5);

%Z = struct('y',Y,'x',Xs);
%X = struct('x',Xs);

%Z.mat = [Z.y,Z.x];
%X.mat = [X.x];

% conduct the test

[kcm_h,kcm_mh,kcm_p,kcm_bvals] = kcm(Z,X,@gres_linear,theta,@gaussrbf,bsize,alpha);
[icm_h,icm_mh,icm_p,icm_bvals] = icmtest_simple(Z,X,gres_linear,@icm_grad_linear,@icm_loss_linear,theta,bsize,alpha);
[smooth_h,smooth_mh,smooth_p,smooth_bvals] = smoothtest(Z,X,gres_linear,theta,bsize,alpha);


% report the results
[kcm_p, icm_p, smooth_p]
