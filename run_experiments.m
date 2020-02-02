%% run experiments with varying sample sizes 
%
addpath('./utils')  

%% Initialize parameters

rng(9) % For reproducibility

dim = 5;
alpha = 0.05;
delta = 0.05;
bsize = 200;
num_repeats = 100;
ns = [100,200,300,400,500,600,700,800,900,1000];

tests = {'kcm','smooth','icm'};

%% Experiment 1: Linear Regression with Homogeneous Error

dgp = "linreg_hom";
multiple_experiments(dgp,tests,ns,dim,delta,num_repeats,bsize,alpha);

%% Experiment 2: Linear Regression with Heterogeneous Error

dgp = "linreg_het";
multiple_experiments(dgp,tests,ns,dim,delta,num_repeats,bsize,alpha);

%% Experiment 3: Simultaneous Equation Model

dgp = "simeq";
multiple_experiments(dgp,tests,ns,dim,delta,num_repeats,bsize,alpha);