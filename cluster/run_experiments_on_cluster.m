function run_experiments_on_cluster(dgp,experiment_name,trial_no)

addpath('../')
addpath('../utils')

% initialization

rng(9) % For reproducibility

dim = 5;
alpha = 0.05;
delta = 0.01;
bsize = 1000;
ns = [100,200,400,600,800,1000];
tests = {'kcm','icm','smooth'};

outfile = strcat('results/',dgp,'_',experiment_name,'_',trial_no,'.dat');

% experiment
multiple_experiments_on_cluster(dgp,tests,ns,dim,delta,1,bsize,alpha,outfile);