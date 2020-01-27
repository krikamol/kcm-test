%% KCM EXPERIMENTS 
%
addpath('./utils')  

%% initialize parameters

rng("default") % For reproducibility

alpha = 0.05;
bsize = 200;

%% Experiment 1

dgp = "linreg_hom";
ns = [100,200,300];
delta = 0.5;
num_repeats = 100;

multiple_experiments(dgp,ns,delta,num_repeats,bsize,alpha);