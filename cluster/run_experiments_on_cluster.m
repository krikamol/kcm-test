function run_experiments_on_cluster(dgp,experiment_name,trial_no)

addpath('../')
addpath('../utils')

% initialization
rng(trial_no) % For reproducibility

alpha = 0.05;
bsize = 1000;
tests = {'kcm','icm','smooth'};
if strcmp(experiment_name,'samplesize') 
    dim = 5;
    delta = 0.01;
    ns = [100,200,400,600,800,1000];
elseif strcmp(experiment_name,'delta')
    dim = 5;
    delta = linspace(1e-4,1e-2,6);
    ns = 100;
elseif strcmp(experiment_name,'error')
    dim = 5;
    alpha = 0.05;
    delta = 0.0;
    ns = [100,200,400,600,800,1000];
end

outdir = strcat('results/',dgp,'/',experiment_name,'/');
outfile = strcat(outdir,dgp,'_',experiment_name,'_',int2str(trial_no+1),'.mat');

% initiate experiments
multiple_experiments_on_cluster(dgp,tests,ns,dim,delta,1,bsize,alpha,outfile);
