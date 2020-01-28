%% KCM EXPERIMENTS 
%
addpath('./utils')  

%% initialize parameters

rng(9) % For reproducibility

alpha = 0.05;
bsize = 500;

%% Experiment 1

dgp = "linreg_hom";
ns = [50,100,200,300];
delta = 0.05;
num_repeats = 200;

multiple_experiments(dgp,ns,delta,num_repeats,bsize,alpha);