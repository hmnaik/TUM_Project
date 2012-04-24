function res = exercise1()

p = [0 0;1 0;1 1;0 1;0.5 1.6;1 1;0 0;0 1;1 0]';
p_h = [p; ones(1,9)];
plot(p(1,:),p(2,:)); axis equal

% point b
T1 = [ 1 0 3; 0 1 -4; 0 0 1];

% point c
arad = degtorad(20);
T2 =[ cos(arad) sin(arad) 0; -sin(arad) cos(arad) 0; 0 0 1];

% point d
T3 = T1 * T2;

% point e
T4 = T2 * T1;

% point f
% R = T2;
% t = [3 -4]';
%T3 = [R t; 0 1];

%T4 = 

% Exercise 4

% point a
A = [1 2 0; 0.5 3 0; 0 0 1];
res = A * p_h;
plotHomo(res);

%point b
Ab = [ 2 -1 0; -0.5 1 0; 0 0 1];
res = Ab * p_h;
plotHomo(res);

% Exercise 5
%point a
Ac = [1 0 0; 0 1 0; 0.3 0.5 1];
res = Ac * p_h;
plotHomo(res);

%point b
Ad = [4 0 0; 0 4 0; 0 0 4];
res = Ad * p_h;
plotHomo(res);

disp('the matrix is actually a scaled identity, so the image is not deformed by the transformation');

pause;
close all;