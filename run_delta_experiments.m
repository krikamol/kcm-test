%% run experiments with varying values of delta
%
addpath('./utils')  

%% initialize parameters
rng(99) % For reproducibility

dim = 5;
alpha = 0.05;
delta = linspace(1e-4,1e-2,6);
bsize = 1000;
num_repeats = 300;
ns = 500;

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
