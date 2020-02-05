function [grad] = icm_grad_linear(Z,theta)

grad = [Z.x, ones(size(Z.x,1),1)];

end

