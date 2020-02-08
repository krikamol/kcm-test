%% run experiments with varying sample sizes 
%
addpath('./utils')

%% Initialize parameters

% debug mode
% profile on;

rng(9) % For reproducibility

dim = 10;
alpha = 0.05;
delta = 0;
bsize = 1000;
num_trials = 500;
ns = [20,50,100,200,500];

tests = {'kcm','smooth'};

%% Experiment 1: Linear Regression with Homogeneous Error

dgp = "linreg_hom";
multiple_experiments(dgp,tests,ns,dim,delta,num_trials,bsize,alpha);

%% Experiment 2: Linear Regression with Heterogeneous Error

dgp = "linreg_het";
multiple_experiments(dgp,tests,ns,dim,delta,num_trials,bsize,alpha);

%% Experiment 3: Simultaneous Equation Model

dgp = "simeq";
multiple_experiments(dgp,tests,ns,dim,delta,num_trials,bsize,alpha);