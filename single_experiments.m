function [pwr,err] = single_experiments(dgp,n,delta,num_exps,alpha)
%SINGLE_EXPERIMENTS Conduct repeated experiments for one parameter
%setting.
%
%   INPUT: 
%       dgp - the data generating process
%       n - sample size
%       delta - the parameter controlling the deviation from the null (vector)
%       num_exps - the number of repeated experiments
%       alpha - significance level
%
%   OUTPUT:
%       pwr - power of the test
%       err - type-I error
%

% initialize variables
decs = zeros(1,num_exps);
true_decs = delta > 0;

for i=1:num_exps
    % generate data
    [Z,X] = generate_data(dgp,delta(i),n);

    % estimate the parameters
    theta = estimate_parameters(dgp,Z,X);

    % conduct the tests
    [h,~,~,~] = kcm(Z,X,gres,theta,kern,bsize,alpha);
    decs(i) = h;
end

[pwr,err] = compute_errors(decs,true_decs);

end

