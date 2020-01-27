%% KCM EXPERIMENTS 
%
addpath('./utils')  

%% initialize parameters

rng("default") % For reproducibility

alpha = 0.05;
bsize = 500;

%% Experiment 1

dgp = "linreg_hom";
ns = [100,200,300,400,500,600,700,800,900,1000];
delta = 0.0;
num_repeats = 200;

multiple_experiments(dgp,ns,delta,num_repeats,bsize,alpha);