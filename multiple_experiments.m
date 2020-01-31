function multiple_experiments(dgp,tests,ns,delta,num_repeats,bsize,alpha)
%MULTIPLE_EXPERIMENTS Conduct experiments with varying sample sizes
%   Detailed explanation goes here

pwrs = zeros(length(tests),length(ns));
errs = zeros(length(tests),length(ns));

for i=1:length(tests)
    for j=1:length(ns)
        [pwr,err] = single_experiments(dgp,char(tests(i)),ns(j),delta,num_repeats,bsize,alpha);
        pwrs(i,j) = pwr;
        errs(i,j) = err;
    end
end

if strcmp(dgp,'linreg_hom')
    plot_title = 'Linear Regression (HM)';
elseif strcmp(dgp,'linreg_het')
    plot_title = 'Linear Regression (HT)';
elseif strcmp(dgp,'simeq')
    plot_title = 'Simultaneous Equations';
else
    error('KCM: The specified DGP is unavailable.');
end

legs = {'KCM','SMOOTH'};
generate_plot(pwrs,ns,"Sample Size ($n$)","Test Power ($1-\beta$)",plot_title,legs,strcat(dgp,'_test_power.eps'));
generate_plot(errs,ns,"Sample Size ($n$)","Type-I Error",plot_title,legs,strcat(dgp,'_type1_error.eps'));

end