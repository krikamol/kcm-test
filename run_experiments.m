%% KCM EXPERIMENTS 
%
addpath('./utils')  

%% initialize parameters

rng("default") % For reproducibility

alpha = 0.05;
bsize = 200;

%% Experiment 1

dgp = "linreg_hom";
ns = [20,50,80,100,120,150,180,200];
delta = 0.05;
num_repeats = 100;

multiple_experiments(dgp,ns,delta,num_repeats,bsize,alpha);