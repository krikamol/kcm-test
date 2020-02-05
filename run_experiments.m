%% run experiments with varying sample sizes 
%
addpath('./utils')  

%% Initialize parameters

rng(9) % For reproducibility

dim = 5;
alpha = 0.05;
delta = 0.05;
bsize = 300;
num_repeats = 100;
ns = [20,50,100,200,500];

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