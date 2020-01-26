function [ theta ] = estimate_parameters(dgp,Z,X)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

if strcmp(dgp,'linreg_hom') || strcmp(dgp,'linreg_het')

    %
    
elseif strcmp(dgp,'simeq')
    %
      
else
    % no specified dgp 
    error('KCM: The specified DGP is unavailable.');
end


end

