% ART - Algebraic Reconstruction Technique
function x = art(A, b, iterations, lambda)

tic;

% set parameters
dim = sqrt( size(A, 2) );
rows = size(A, 1);

if nargin < 4
    lambda = 1;
end;

% initialize algorithm
x = zeros(1,size(A,2));

for i = 1:size(A,1)
    norms(i) = norm(A(i,:));
end

for iter = 1:iterations

    for row = 1:rows
        % perform iteration
        
        % find projection j on a plane
        j = randsample(size(A,1),1,true,norms);
        % compute factor lambda
        factor = lambda * (b(j) - sum(A(j,:).*x))/sum(A(j,:).*A(j,:));
        % update solution
        x = x + factor .* A(j,:);
    end

end;

x = reshape(x, dim, dim);

elapsed = toc;
disp(['ART done in ' num2str(elapsed) ' seconds.']);

