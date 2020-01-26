function [ output_args ] = multiple_experiments(dgp,ns,delta,num_repeats,alpha)
%MULTIPLE_EXPERIMENTS Conduct experiments with varying sample sizes
%   Detailed explanation goes here

pwrs = [];
errs = [];

for i=1:length(ns)

    [pwr,err] = single_experiments(dgp,ns(i),delta,num_repeats,alpha);
    pwrs = horzcat(pwrs,pwr);
    errs = horzcat(errs,err);
    
end

generate_plot(pwrs,ns,"sample size","power",dgp,"test_power.eps");
generate_plot(errs,ns,"sample size","Type-I Error",dgp,"test_error.eps");

end

