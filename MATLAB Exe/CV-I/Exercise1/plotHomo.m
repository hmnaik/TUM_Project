function r = plotHomo(A)
A_n = bsxfun(@rdivide,A,A(end,:));
figure; plot(A_n(1,:),A_n(2,:)); axis equal
r = A_n;
