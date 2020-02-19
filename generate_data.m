function [Z,X,gres] = generate_data(dgp,delta,n,d)
%GENERATE_DATA generates data according to the specified DGP.
%   
%   INPUT: 
%       dgp - the data generating process ('linreg_hom','linreg_het','simeq')
%       delta - the parameter controlling the deviation from the null
%       n - sample size
%       d - dimensionality of X
%
%   OUTPUT: 
%       Z,X - the data matrices
%       gres - a function handle of generalized residual function
%

if strcmp(dgp,'linreg_hom') || strcmp(dgp,'linreg_het')
    % 
    theta = ones([1,d+1]); 
    inv_mill_ratio = @(a) normpdf(a)./normcdf(a);
    
    Xs = normrnd(0,1,[n,d]);
    
    err = normrnd(0,0.05,[n,1]); % homoskedastic noise
    if strcmp(dgp,'linreg_het')
        err = err.*sqrt(0.1 + 0.1.*(vecnorm(Xs,2,2).^2)); % heteroskedastic noise
    end
    
    %Y = theta(1) + Xs*theta(2:end)' + delta.*inv_mill_ratio((theta(1) + Xs*theta(2:end)')) + err;
    Y = theta(1) + Xs*theta(2:end)' + err;
    
    Z = struct('y',Y,'x',Xs);
    X = struct('x',Xs); 
    
    Z.mat = [Z.y,Z.x];
    X.mat = [X.x];
    
    gres = @gres_linear;
    
elseif strcmp(dgp,'simeq')
    %
    L11 = -1;
    L12 = 1;
    L21 = 1;
    L22 = 1;
    
    %
    V = mvnrnd([0,0],[1,1/sqrt(2);1/sqrt(2),1],n);
    R = normrnd(0,1,[n,1]);
    W = normrnd(0,1,[n,1]);
    
    Q = L11.*R + L12.*W + V(:,1);
    %P = L21.*R + L22.*W + (delta/2.0).*(W.*W) + V(:,2);
    P = L21.*R + L22.*W + V(:,2);
    
    Z = struct('q',Q,'p',P,'r',R,'w',W);
    X = struct('r',R,'w',W);
    
    Z.mat = [Z.q,Z.p,Z.r,Z.w];
    X.mat = [X.r,X.w];
    
    gres = @gres_simultaneous;
    
else
    % no specified dgp 
    error('KCM: The specified DGP is unavailable.');
end

end

