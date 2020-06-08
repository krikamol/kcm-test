%% experiments with varying dimensionality
%
addpath('./utils')  

%% Initialize parameters

rng(9) % For reproducibility

dim = [1,2,3,4,5];
alpha = 0.05;
delta = 0.05;
bsize = 500;
num_repeats = 200;
ns = 100;

tests = {'kcm','smooth'};

%% Experiment 1: Linear Regression with Homogeneous Error

dgp = "linreg_hom";
multiple_experiments(dgp,tests,ns,dim,delta,num_repeats,bsize,alpha);

%% Experiment 2: Linear Regression with Heterogeneous Error

dgp = "linreg_het";
multiple_experiments(dgp,tests,ns,dim,delta,num_repeats,bsize,alpha);

%% Experiment 3: Simultaneous Equation Model

dgp = "simeq";
multiple_experiments(dgp,tests,ns,dim,delta,num_repeats,bsize,alpha);