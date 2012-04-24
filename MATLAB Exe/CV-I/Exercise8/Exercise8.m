function Exercise8()

close all; clear all; clc;

X = [ 0 0 0 ;
      0 0 4 ;
      0 4 0 ;
      0 4 4 ;
      -4 0 4;
      -4 4 4;
      -4 4 0;
      -4 0 0]';

x = [ -8.4853 -3.9470 -5.6569 -3.0127 -3.8140 -3.1142 -5.0212 -6.5783 ;
    5.1962 2.5648 5.1962 3.1877 1.3821 2.0820 3.1877 2.5648];

% normalization

[M N] = size(X);
[m n] = size(x);

centroid = [ sum(x(1,:))/n; sum(x(2,:))/n];
Centroid = [ sum(X(1,:))/N; sum(X(2,:))/N; sum(X(3,:))/N ];

Xt = X - repmat([Centroid(1); Centroid(2); Centroid(3)], 1, N);
xt = x - repmat([centroid(1); centroid(2)], 1, n);

Xdist = sqrt(Xt(1,:).^2 + Xt(2,:).^2 + Xt(3,:).^2);
AVdist = sum(Xdist)/N;
Scalfactor = sqrt(3)/AVdist;
Xtn = Xt.*Scalfactor;

U = [Scalfactor     0           0           -Scalfactor*Centroid(1);
        0       Scalfactor      0           -Scalfactor*Centroid(2);
        0           0       Scalfactor      -Scalfactor*Centroid(3);
        0           0           0                       1];


xdist = sqrt(xt(1,:).^2 + xt(2,:).^2);
avdist = sum(xdist)/n;
scalfactor = sqrt(2)/avdist;
xtn = xt.*scalfactor;

T = [scalfactor   0           -scalfactor*centroid(1);
        0       scalfactor     -scalfactor*centroid(2);
        0           0                       1];
    
Xtn(4,:) = ones(1,N);
xtn(3,:) = ones(1,n);
    
myzero = [0 0 0 0];

for i = 1:n
    A(i*2-1,:)=[myzero -xtn(3,i)*Xtn(:,i)' xtn(2,i)*Xtn(:,i)'];
    A(i*2,:)=[xtn(3,i)*Xtn(:,i)' myzero -xtn(1,i)*Xtn(:,i)'];
end

[Usvd,S,V] = svd(A);

disp ('matrix before non-linear optimization');
H = reshape(V(:,end),4,3)';
H = H / H(3,4)

Pt = H;

function err = geometric_error(Ve)
    Ptt = reshape(Ve,4,3)';
    Ptt = Ptt / Ptt(3,4);
    PX = Ptt*Xtn;
    PXt = bsxfun(@rdivide, PX,PX(3,:));
    err = xtn - PXt;
end

disp('starting geometric error');
geometric_error(V(:,end))
 
options = optimset('Algorithm', 'levenberg-marquardt','Display','off');
Pto = lsqnonlin(@geometric_error,V(:,end),[],[],options);

disp('final geometric error');
geometric_error(Pto)

disp('RESULT: final matrix');
Pt = reshape(Pto,4,3)';
Pt = Pt./Pt(3,4)
disp('after denormalization');
P = T\Pt*U

x

finalx = P * [X' ones(size(X,2),1)]';
finalx = bsxfun(@rdivide,finalx,finalx(3,:));
finalx = finalx(1:2,:)
disp('difference')
finalx - x

end
