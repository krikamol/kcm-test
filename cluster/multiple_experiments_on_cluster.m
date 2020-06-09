function multiple_experiments_on_cluster(dgp,tests,ns,dim,delta,num_repeats,bsize,alpha,outfile)
%MULTIPLE_EXPERIMENTS_ON_CLUSTER Conduct multiple experiments on the cluster

pwrs = [];
errs = [];

% run with varying sample sizes
if length(ns) > 1 && length(delta) == 1 && length(dim) == 1

    pwrs = zeros(length(tests),length(ns));
    errs = zeros(length(tests),length(ns));

    for i=1:length(ns)
        [pwr,err] = single_experiments(dgp,tests,ns(i),dim,delta,num_repeats,bsize,alpha);
        pwrs(:,i) = pwr;
        errs(:,i) = err;
    end

% run with varying values of delta
elseif length(ns) == 1 && length(delta) > 1 && length(dim) == 1
    
    pwrs = zeros(length(tests),length(delta));
    errs = zeros(length(tests),length(delta));

    for i=1:length(delta)
        [pwr,err] = single_experiments(dgp,tests,ns,dim,delta(i),num_repeats,bsize,alpha);
        pwrs(:,i) = pwr;
        errs(:,i) = err;
    end

% run with varying dimensions
elseif length(ns) == 1 && length(delta) == 1 && length(dim) > 1
    
    pwrs = zeros(length(tests),length(dim));
    errs = zeros(length(tests),length(dim));

    for i=1:length(delta)
        [pwr,err] = single_experiments(dgp,tests,ns,dim(i),delta,num_repeats,bsize,alpha);
        pwrs(:,i) = pwr;
        errs(:,i) = err;
    end
    
else
    error('KCM: Invalid setting.');
end


% save the result
results = {pwrs, errs};
save(outfile,'results');

end