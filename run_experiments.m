%% KCM EXPERIMENTS 
%
addpath('./utils')  

%% initialize parameters

rng(9) % For reproducibility

alpha = 0.05;
bsize = 1000;
num_repeats = 500;

%% Experiment 1

dgp = "linreg_hom";
ns = [100,200,300,400,500,600,700,800,900,1000];
delta = 0.05;

multiple_experiments(dgp,ns,delta,num_repeats,bsize,alpha);

%% Experiment 2

dgp = "linreg_het";
ns = [50,100,200,300,400,500,1000];
delta = 0.05;

multiple_experiments(dgp,ns,delta,num_repeats,bsize,alpha);