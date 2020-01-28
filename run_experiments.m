%% KCM EXPERIMENTS 
%
addpath('./utils')  

%% initialize parameters

rng(9) % For reproducibility

alpha = 0.05;
bsize = 1000;
num_repeats = 500;

%% Experiment 1: Linear Regression with Homogeneous Error

dgp = "linreg_hom";
ns = [100,200,300,400,500,600,700,800,900,1000];
delta = 0.05;

multiple_experiments(dgp,ns,delta,num_repeats,bsize,alpha);

%% Experiment 2: Linear Regression with Heterogeneous Error

dgp = "linreg_het";
ns = [50,100,200,300,400,500,1000];
delta = 0.05;

multiple_experiments(dgp,ns,delta,num_repeats,bsize,alpha);

%% Experiment 3: Simultaneous Equation Model

dgp = "simeq";
ns = [50,100,200,300,400,500];
delta = 0.05;

multiple_experiments(dgp,ns,delta,num_repeats,bsize,alpha);