function multiple_experiments(dgp,ns,delta,num_repeats,bsize,alpha)
%MULTIPLE_EXPERIMENTS Conduct experiments with varying sample sizes
%   Detailed explanation goes here

pwrs = [];
errs = [];

for i=1:length(ns)

    [pwr,err] = single_experiments(dgp,ns(i),delta,num_repeats,bsize,alpha);
    pwrs = horzcat(pwrs,pwr);
    errs = horzcat(errs,err);

end

if strcmp(dgp,'linreg_hom')
    plot_title = 'Linear Regression (HM)';
elseif strcmp(dgp,'linreg_het')
    plot_title = 'Linear Regression (HT)';
elseif strcmp(dgp,'simeq')
    plot_title = 'Simultaneous Equations';
end

legs = ['KCM'];
generate_plot(pwrs,ns,"Sample Size ($n$)","Test Power ($1-\beta$)",plot_title,legs,strcat(dgp,'_test_power.eps'));
generate_plot(errs,ns,"Sample Size ($n$)","Type-I Error",plot_title,legs,strcat(dgp,'_type1_error.eps'));

end