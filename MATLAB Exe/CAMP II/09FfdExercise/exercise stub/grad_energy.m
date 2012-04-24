function [gradient_E,diff] = grad_energy(phi, R, T, d_ctrl, n_ctrl)

d = prod(n_ctrl);
n_img = size(R);
f = fspecial('sobel');
gradient_E = zeros(d*2, 1);

% Precompute terms of gradient that are identical 
% for all partial derivatives (product of difference image
% and image gradients of the template in x and y:
% YOUR CODE HERE



R = imfilter( n_img , f);




for i=1:d

    % Compute parts of gradient that are not identical
    % for each of the partial derivatives (of E with respect
    % to each of the control points):
    % YOUR CODE HERE
    if(i ~= d)
     gradient_E(i  ,1) = phi(i) - phi(i+1);
     gradient_E(i+d,1) = phi(i+d) - phi (i+d+1);
    end
end