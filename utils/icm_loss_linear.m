function [L] = icm_loss_linear(Z,theta)

X = [Z.x, ones(size(Z.x,1),1)];
G = gres_linear(Z,theta);
 
[n,d] = size(X,1);
q = size(G,2);

L = zeros(n,d,q);
C = zeros(d,d);

for j=1:n
    C = C + X(j,:)'*X(j,:);
end    
C = C./n;

for i=1:n
    L(i,:,:) = -(C\X(i,:)')*G(i,:);
end

end

