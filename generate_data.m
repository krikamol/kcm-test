function [Z,X,gres] = generate_data(dgp,delta,n)
%GENERATE_DATA generates data according to the specified DGP.
%   
%   INPUT: 
%       dgp - the data generating process ('linreg_hom','linreg_het','simeq')
%       delta - the parameter controlling the deviation from the null
%       n - sample size
%
%   OUTPUT: 
%       Z,X - the data matrices
%       gres - a function handle of generalized residual function
%

if strcmp(dgp,'linreg_hom') || strcmp(dgp,'linreg_het')
    % 
    theta_1 = 1.0; 
    theta_2 = 2.0;
    inv_mill_ratio = @(a) normpdf(a)./normcdf(a);
    
    Xs = normrnd(0,1,[n,1]);
    
    err = normrnd(0,0.01,[n,1]); % homoskedastic noise
    if strcmp(dgp,'linreg_het')
        err = err.*sqrt(0.1 + 0.1.*(Xs.^2)); % heteroskedastic noise
    end
    
    Y = theta_1 + theta_2.*Xs + delta.*inv_mill_ratio((theta_1 + theta_2.*Xs)) + err;
    
    X = struct('x',Xs);
    Z = struct('y',Y,'x',Xs);
    gres = @gres_linear;
    
elseif strcmp(dgp,'simeq')
    %
    alpha_d = -1;
    beta_d = 1;
    alpha_s = 1;
    beta_2 = 1;
    
    % TODO
    
    Z = struct('q',Q,'p',P,'r',R,'w',W);
    X = struct('r',R,'w',W);
    gres = @gres_simultaneous;
    
else
    % no specified dgp 
    error('KCM: The specified DGP is unavailable.');
end

end

