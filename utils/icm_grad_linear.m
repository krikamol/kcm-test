function [grad] = icm_grad_linear(Z,theta)

d = length(theta);
n = size(Z.x,1);

grad = zeros(n,d,1);
grad(:,:,1) = [Z.x, ones(n,1)];

end

