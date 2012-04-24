function r = mydlt(x,xf)

[mf nf] = size(xf);
[m n] = size(x);
xf(3,:) = ones(1,nf);
x(3,:) = ones(1,n);

if mf ~= m || nf ~= n || m ~= 2 || n < 4
    disp('please enter at least 4 correspondences');
    return
end

myzero = [0 0 0];

for i = 1:n
    A(i*2-1,:)=[myzero -xf(3,i)*x(:,i)' xf(2,i)*x(:,i)'];
    A(i*2,:)=[xf(3,i)*x(:,i)' myzero -xf(1,i)*x(:,i)'];
end

[U,S,V] = svd(A);
% [value, index] = min(S,[],2);
H = reshape(V(:,end),3,3)';
H = H / H(3,3);

r = H;
% 
% figure(6); plot(x(1,:),x(2,:)); title('Original');
% 
% myxf = H*x;
% myxf = bsxfun(@rdivide,myxf,myxf(3,:));
% 
% figure(7); plot(xf(1,:),xf(2,:)); title('Original_f');
% 
% figure(8); plot(myxf(1,:),myxf(2,:)); title('Transformed');
% pause

close all