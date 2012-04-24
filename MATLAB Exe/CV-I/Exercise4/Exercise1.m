u = (1:1:100)';
v = 2*u(:)-1;

data = [u(:) v(:)];

noise = 0.3*randn(size(data));
data = data + noise;


A = [data ones(size(data,1),1)];

[U,S,V] = svd(A);

l = V(:,end);

m = -l(1)/l(2);
q = -l(3)/l(2);

% using y = mx + c
est_data = data(:,1)*m+q;

plot(data(:,1),data(:,2),'rx');
hold on;
plot(data(:,1),est_data(:));
hold off;

normTerm = sqrt(l(1)^2+l(2)^2);
terms = bsxfun(@times,A,l'./normTerm);
dist = abs(sum(terms,2));
std = sqrt(sum(dist.^2)/size(data,1))



disp('Press enter to get next Calculation');

pause

for i = 1:100
    noise = 0.3*randn(size(data));
    data = sort(data + noise);
end

meanData = [mean(data(1,:)) mean(data(2,:))]

normData = data - repmat(meanData,size(data,1),1)

A = [normData ones(size(data,1),1)];

[U,S,V] = svd(A);

l = V(:,end-1);

m = -l(1)/l(2);
q = -l(3)/l(2);

plot(data(:,1),data(:,2),'rx');
hold on;
plot(data(:,1),data(:,1)*m+q);
hold off;

normTerm = sqrt(l(1)^2+l(2)^2);
terms = bsxfun(@times,A,l'./normTerm);
dist = abs(sum(terms,2));
std = sqrt(sum(dist.^2)/size(data,1))

disp('Press Enter to finish the program');
pause
close all