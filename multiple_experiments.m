function multiple_experiments(dgp,tests,ns,dim,delta,num_repeats,bsize,alpha)
%MULTIPLE_EXPERIMENTS Conduct experiments with varying sample sizes
%   Detailed explanation goes here


if strcmp(dgp,'linreg_hom')
    plot_title = 'Linear Regression (HM)';
elseif strcmp(dgp,'linreg_het')
    plot_title = 'Linear Regression (HT)';
elseif strcmp(dgp,'simeq')
    plot_title = 'Simultaneous Equations';
else
    error('KCM: The specified DGP is unavailable.');
end

if length(ns) > 1 && length(delta) == 1

    pwrs = zeros(length(tests),length(ns));
    errs = zeros(length(tests),length(ns));

    for i=1:length(ns)
        [pwr,err] = single_experiments(dgp,tests,ns(i),dim,delta,num_repeats,bsize,alpha);
        pwrs(:,i) = pwr;
        errs(:,i) = err;
    end
    
    legs = {'KCM','SMOOTH'};
    generate_plot(pwrs,ns,"Sample Size ($n$)","Test Power ($1-\beta$)",plot_title,legs,strcat(dgp,'_samplesize_test_power.eps'));
    generate_plot(errs,ns,"Sample Size ($n$)","Type-I Error",plot_title,legs,strcat(dgp,'_samplesize_type1_error.eps'));

elseif length(ns) == 1 && length(delta) > 1
    
    pwrs = zeros(length(tests),length(delta));
    errs = zeros(length(tests),length(delta));

    for i=1:length(delta)
        [pwr,err] = single_experiments(dgp,tests,ns,dim,delta(i),num_repeats,bsize,alpha);
        pwrs(:,i) = pwr;
        errs(:,i) = err;
    end

    legs = {'KCM','SMOOTH'};
    generate_plot(pwrs,delta,"$\delta$","Test Power ($1-\beta$)",plot_title,legs,strcat(dgp,'_delta_test_power.eps'));
    generate_plot(errs,delta,"$\delta$","Type-I Error",plot_title,legs,strcat(dgp,'_delta_type1_error.eps'));
    
else
    error('KCM: Invalid setting.');
end

end