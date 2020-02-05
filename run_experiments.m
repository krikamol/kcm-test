%% run experiments with varying sample sizes 
%
addpath('./utils')  

%% Initialize parameters

rng(9) % For reproducibility

dim = 1;
alpha = 0.05;
delta = 0.05;
bsize = 500;
num_repeats = 300;
ns = [100,200,300,400,500];

tests = {'kcm','icm','smooth'};

%% Experiment 1: Linear Regression with Homogeneous Error

dgp = "linreg_hom";
multiple_experiments(dgp,tests,ns,dim,delta,num_repeats,bsize,alpha);

%% Experiment 2: Linear Regression with Heterogeneous Error

dgp = "linreg_het";
multiple_experiments(dgp,tests,ns,dim,delta,num_repeats,bsize,alpha);

%% Experiment 3: Simultaneous Equation Model

dgp = "simeq";
multiple_experiments(dgp,tests,ns,dim,delta,num_repeats,bsize,alpha);