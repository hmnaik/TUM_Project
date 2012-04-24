function r = mydlt_norm(x,xf)

[mf nf] = size(xf);
[m n] = size(x);
% xf(3,:) = ones(1,nf);
% x(3,:) = ones(1,n);

if mf ~= m || nf ~= n || m ~= 2 || n < 4
    disp('please enter at least 4 correspondences');
    return
end

centroid = [ sum(x(1,:))/n; sum(x(2,:))/n ];
centroidf = [ sum(xf(1,:))/nf; sum(xf(2,:))/nf ];

xft = xf - repmat([centroidf(1); centroidf(2)], 1, nf);
xt = x - repmat([centroid(1); centroid(2)], 1, n);

% disp('centroids');
% [ sum(xt(1,:))/n; sum(xt(2,:))/n ]
% [ sum(xft(1,:))/nf; sum(xft(2,:))/nf ]
% figure; plot(x(1,:),x(2,:));
% figure; plot(xt(1,:), xt(2,:));

xfdist = sqrt(xft(1,:).^2 + xft(2,:).^2);
avfdist = sum(xfdist)/nf;
scalfactorf = sqrt(2)/avfdist;
xftn = xft.*scalfactorf;

% xftn(1:2,:) = xft(1:2,:).*(scalfactorf);
% disp('area 1')
% sum(sqrt(xftn(1,:).^2 + xftn(2,:).^2))/n

% xftn(3,:) = ones(1,nf);
Tf = [scalfactorf 0 -scalfactorf*centroidf(1);
        0 scalfactorf -scalfactorf*centroidf(2);
        0       0               1];


xdist = sqrt(xt(1,:).^2 + xt(2,:).^2);
avdist = sum(xdist)/n;
scalfactor = sqrt(2)/avdist;
xtn = xt.*scalfactor;

% xtn(1:2,:) = xt(1:2,:).*(scalfactor);
% disp('area 2')
% sum(sqrt(xtn(1,:).^2 + xtn(2,:).^2))/n

% xtn(3,:) = ones(1,n);
T = [scalfactor 0 -scalfactor*centroid(1);
        0 scalfactor -scalfactor*centroid(2);
        0       0               1];

Hf = mydlt(xtn,xftn);

H = (inv(Tf)*Hf*T);
H = H / H(3,3);

%h_xtn = [xtn;ones(1,size(xtn,2))];
%myx = Hf*h_xtn;
% myx = H * [x;ones(1,size(x,2))];
% myx = bsxfun(@rdivide,myx(1:2,:),myx(3,:));
% figure(6); plot(myx(1,:),myx(2,:)); title('transformed');

% myxf = H*[xf; ones(1,nf)];
% for i = 1:nf
%     myxft(:,i) = myxf(1:2,i)./myxf(3,i);
% end
% myxft

% myxf = xf;

% asdfasdf =  Hf*Tf*[xf; ones(1,nf)];
% for i = 1:nf
%     asdfasdf(:,i)./asdfasdf(3,i)
% end

% figure(7); plot(myxf(1,:),myxf(2,:)); title('original');


r = H;