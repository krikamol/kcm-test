function [pwrs,errs] = single_experiments(dgp,tests,n,delta,num_exps,bsize,alpha)
%SINGLE_EXPERIMENTS Conduct repeated experiments for one parameter
%setting.
%
%   INPUT: 
%       dgp - the data generating process
%       tests - the test statistics: 'kcm','icm','smooth','mtest'
%       n - sample size
%       delta - the parameter controlling the deviation from the null
%       num_exps - the number of repeated experiments
%       bsize - the size of bootstrap sample
%       alpha - significance level
%
%   OUTPUT:
%       pwrs - power of the tests
%       errs - type-I errors
%

% initialize variables
n_tests = length(tests);

pwrs = zeros(n_tests,1);
errs = zeros(n_tests,1);

decs = zeros(n_tests,num_exps);
true_decs = zeros(1,num_exps);

for i=1:num_exps
    
    if length(delta) == 1
        cur_delta = delta;
    else
        cur_delta = delta(i);
    end
    
    true_decs(i) = cur_delta > 0;
    
    % generate the synthetic data
    [Z,X,gres] = generate_data(dgp,cur_delta,n);
    
    % estimate the parameters
    theta = estimate_parameters(dgp,Z);

    for t=1:n_tests
        
        % conduct the tests
        if strcmp(tests(t),'kcm')
            % kernel conditional moment (KCM) test
            [h,~,~,~] = kcm(Z,X,gres,theta,@gaussrbf,bsize,alpha);
            decs(t,i) = h;
        elseif strcmp(tests(t),'icm')
            % integrated conditional moment (ICM) test
            [h,~,~,~] = icmtest(Z,X,gres,theta,bsize,alpha);
            decs(t,i) = h;
        elseif strcmp(tests(t),'smooth')
            % smooth test
            [h,~,~,~] = smoothtest(Z,X,gres,theta,bsize,alpha);
            decs(t,i) = h;
        elseif strcmp(tests(t),'mtest')
            % M-test
        else
            error('KCM: The specified test does not exist.');
        end
    end
end

for t=1:n_tests
    [pwrs(t),errs(t)] = compute_errors(decs(t,:),true_decs);
end

end

