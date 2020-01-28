function [pwr,err] = single_experiments(dgp,n,delta,num_exps,bsize,alpha)
%SINGLE_EXPERIMENTS Conduct repeated experiments for one parameter
%setting.
%
%   INPUT: 
%       dgp - the data generating process
%       n - sample size
%       delta - the parameter controlling the deviation from the null
%       num_exps - the number of repeated experiments
%       bsize - the size of bootstrap sample
%       alpha - significance level
%
%   OUTPUT:
%       pwr - power of the test
%       err - type-I error
%

% initialize variables
decs = zeros(1,num_exps);
true_decs = zeros(1,num_exps);

for i=1:num_exps
    
    if length(delta) == 1
        cur_delta = delta;
    else
        cur_delta = delta(i);
    end
        
    [Z,X,gres] = generate_data(dgp,cur_delta,n);
    
    % estimate the parameters
    theta = estimate_parameters(dgp,Z);
    
    % conduct the tests
    [h,~,~,~] = kcm(Z,X,gres,theta,@gaussrbf,bsize,alpha);
    decs(i) = h;
    
    true_decs(i) = cur_delta > 0;
    
end

[pwr,err] = compute_errors(decs,true_decs);

end

