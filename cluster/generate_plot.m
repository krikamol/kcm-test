%% generate plots from results

addpath('../')
addpath('../utils')

dgp = 'linreg_hom';
experiment_name = 'samplesize';

dim = 5;
alpha = 0.05;
delta = 0.01;
num_trials = 10;
ns = [100,200,400,600,800,1000];

tests = {'kcm','icm','smooth'};
legs = {'KCM','ICM','SMOOTH'};

%
if length(ns) > 1 && length(delta) == 1 && length(dim) == 1

    pwrs = zeros(length(tests),length(ns));
    errs = zeros(length(tests),length(ns));

    for i=1:num_trials
        infile = strcat('results/',dgp,'_',experiment_name,'_',int2str(i),'.mat');
        load(infile);
        pwrs = pwrs + results{1};
        errs = errs + results{2};
    end
    
    pwrs = pwrs./num_trials;
    errs = errs./num_trials;
    
    generate_power_plot(pwrs,ns,'Sample Size ($n$)','Test Power ($1-\beta$)',[0,1.1],'',legs,strcat(dgp,'_samplesize_test_power.eps'));
    generate_error_plot(errs,ns,alpha,'Sample Size ($n$)','Type-I Error',[0,0.5],'',legs,strcat(dgp,'_samplesize_type1_error.eps'));

elseif length(ns) == 1 && length(delta) > 1 && length(dim) == 1
    
    pwrs = zeros(length(tests),length(delta));
    errs = zeros(length(tests),length(delta));

    for i=1:num_trials
        infile = strcat('results/',dgp,'_',experiment_name,'_',int2str(i),'.mat');
        load(infile);
        pwrs = pwrs + results{1};
        errs = errs + results{2};
    end
    
    pwrs = pwrs./num_trials;
    errs = errs./num_trials;

    generate_power_plot(pwrs,delta,'$\delta$','Test Power ($1-\beta$)',[0,1.1],'',legs,strcat(dgp,'_delta_test_power.eps'));
    generate_error_plot(errs,delta,alpha,'$\delta$','Type-I Error',[0,0.5],'',legs,strcat(dgp,'_delta_type1_error.eps'));

elseif length(ns) == 1 && length(delta) == 1 && length(dim) > 1
    
    pwrs = zeros(length(tests),length(dim));
    errs = zeros(length(tests),length(dim));

    for i=1:num_trials
        infile = strcat('results/',dgp,'_',experiment_name,'_',int2str(i),'.mat');
        load(infile);
        pwrs = pwrs + results{1};
        errs = errs + results{2};
    end
    
    pwrs = pwrs./num_trials;
    errs = errs./num_trials;

    generate_power_plot(pwrs,dim,'Dimension of $X$','Test Power ($1-\beta$)',[0,1.1],'',legs,strcat(dgp,'_dim_test_power.eps'));
    generate_error_plot(errs,dim,alpha,'Dimension of $X$','Type-I Error',[0,0.5],'',legs,strcat(dgp,'_dim_type1_error.eps'));
    
else
    error('KCM: Invalid setting.');
end