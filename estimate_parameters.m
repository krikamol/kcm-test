function [ theta ] = estimate_parameters(dgp,Z)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

if strcmp(dgp,'linreg_hom') || strcmp(dgp,'linreg_het')

    % fit linear regression
    y = Z.y;
    x = Z.x;
    
    p = polyfit(x,y,1);
    theta = [p(2), p(1)];
    
elseif strcmp(dgp,'simeq')
    
    % two-stage least square
    theta = [-1,1,1,1];
    
    %Pz = z.'*((z*z.')\z);
    %A = ((x*Pz*x.')\x)*Pz;
    %theta = A'*y;
    
else
    % no specified dgp 
    error('KCM: The specified DGP is unavailable.');
end

end