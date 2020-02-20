function [ theta ] = estimate_parameters(dgp,Z,delta)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

if strcmp(dgp,'linreg_hom') || strcmp(dgp,'linreg_het')

    % fit linear regression
    %y = Z.y;
    %x = Z.x;
    
    %p = fitlm(x,y);
    %theta = p.Coefficients.Estimate';
    
    % output the true parameters with a small perturbation
    d = size(Z.x,2);
    theta = ones([1,d+1]) + delta.*normrnd(0,1,[1,d+1]);
    
elseif strcmp(dgp,'simeq')
    
    % two-stage least square
    %Pz = z.'*((z*z.')\z);
    %A = ((x*Pz*x.')\x)*Pz;
    %theta = A'*y;
    ph = feval(fitlm([Z.r,Z.w],Z.p),[Z.r,Z.w]);
    
    t1 = fitlm([ph,Z.r],Z.q).Coefficients.Estimate';
    t2 = fitlm([ph,Z.w],Z.q).Coefficients.Estimate';
    
    % output the true parameters with a small perturbation
    %theta = [1,-2,-1,2] + delta.*normrnd(0,1,[1,4]);
    theta = [t1(2),t1(3),t2(2),t2(3)] + delta.*normrnd(0,1,[1,4]);
    
else
    % no specified dgp 
    error('KCM: The specified DGP is unavailable.');
end

end