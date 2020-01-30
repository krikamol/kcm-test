%% experiments with varying values of delta
%
addpath('./utils')  

%% Initialize parameters

rng(9) % For reproducibility

alpha = 0.05;
delta = [0.01,0.05,0.1,0.5];
bsize = 500;
num_repeats = 300;
ns = [100];

%% Experiment 1: Linear Regression with Homogeneous Error

dgp = "linreg_hom";
multiple_experiments(dgp,ns,delta,num_repeats,bsize,alpha);

%% Experiment 2: Linear Regression with Heterogeneous Error

dgp = "linreg_het";
multiple_experiments(dgp,ns,delta,num_repeats,bsize,alpha);

%% Experiment 3: Simultaneous Equation Model

dgp = "simeq";
ns = [10,20,30,40,50,60,70,80,100];
multiple_experiments(dgp,ns,delta,num_repeats,bsize,alpha);