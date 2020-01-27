%% KCM EXPERIMENTS 
%
addpath('./utils')  

%% initialize parameters

rng(10) % For reproducibility

alpha = 0.05;
bsize = 1000;

%% Experiment 1

dgp = "linreg_hom";
ns = [100,200,300,400,500];
delta = 1.5;
num_repeats = 100;

multiple_experiments(dgp,ns,delta,num_repeats,bsize,alpha);