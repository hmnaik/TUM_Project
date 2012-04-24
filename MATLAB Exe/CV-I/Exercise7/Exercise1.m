
close all;

im1 = imread('im1.png');
im2 = imread('im2.png');

imshow(im1);


% xp = [
%   169.0000  
%   162.0000  
%   170.0000  
%   173.0000  
%   167.0000  
%   168.0000  
%   165.0000  
%   162.0000  
%   164.0000  
%   167.0000 
%   ];
%   
% yp = [
%   163.0000
%   174.0000
%   174.0000
%   165.0000
%   168.0000
%   164.0000
%   168.0000
%   168.0000
%   164.0000
%   165.0000
%   ];

[xp yp] = ginput(10);
m = [mean(xp) mean(yp)];
c = cov([xp yp]);

figure(1);
imshow(im1);
hold on
plot(m(1),m(2),'bx');
error_ellipse(100.*c,m);
hold off

H = [ 0.923535 0.02394 131.650330;
    -0.098678 1.008938 120.014473;
    -0.000134 -0.000013 1.050149];

mf = H*[m';1];
mf = mf/mf(3);
mf = mf(1:2);

syms x y
myj = [ (H(1,1)*(H(3,1)*x+H(3,2)*y+H(3,3)) - (H(1,1)*x + H(1,2)*y + H(1,3))*H(3,1))/(H(3,1)*x+H(3,2)*y+H(3,3))^2 , (H(1,2)*(H(3,1)*x+H(3,2)*y+H(3,3)) - (H(1,1)*x + H(1,2)*y + H(1,3))*H(3,2))/(H(3,1)*x+H(3,2)*y+H(3,3))^2; ...
        (H(2,1)*(H(3,1)*x+H(3,2)*y+H(3,3)) - (H(2,1)*x + H(2,2)*y + H(2,3))*H(3,1))/(H(3,1)*x+H(3,2)*y+H(3,3))^2 , (H(2,2)*(H(3,1)*x+H(3,2)*y+H(3,3)) - (H(1,1)*x + H(1,2)*y + H(1,3))*H(3,2))/(H(3,1)*x+H(3,2)*y+H(3,3))^2 ];

myje = subs(myj,{x,y},{mf(1),mf(2)});
cf = myje*c*myje';


figure(2);
imshow(im2);
hold on ;
plot(mf(1),mf(2),'rx');
error_ellipse(100.*c,mf);
error_ellipse(100.*cf,mf,'style','r--');
hold off ;

%pause ;
%close all;