function [ theta ] = estimate_parameters(dgp,Z)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

if strcmp(dgp,'linreg_hom') || strcmp(dgp,'linreg_het')

    % perform linear regression
    y = Z.y;
    x = Z.x;
    
    mdl = fitlm(y,x);
    theta = [mdl.Coefficients.Estimate(1),mdl.Coefficients.Estimate(2)];
    
elseif strcmp(dgp,'simeq')
    %
      
else
    % no specified dgp 
    error('KCM: The specified DGP is unavailable.');
end

end