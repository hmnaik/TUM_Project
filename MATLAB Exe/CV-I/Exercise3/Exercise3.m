function r = Exercise3()

im = imread('Skyscraper.jpg');

imshow(im);
disp('Please click on two points on each of two parallel lines')
[x,y] = ginput(4);
disp('Please repeat the process with another couple of lines')
[x(5:8),y(5:8)] = ginput(4);

% x = [ 93.0000
%   152.0000
%   168.0000
%   189.0000
%   282.0000
%   179.0000
%   152.0000
%    15.0000];
% 
% 
% y = [ 366.0000
%    51.0000
%   389.0000
%   114.0000
%   287.0000
%   311.0000
%    51.0000
%   113.0000 ]';



for i = 1:4
    l(:,i) = cross([x(i*2-1);y(i*2-1);1],[x(i*2);y(i*2);1]);
end

hold on;
for i = 1:4
    myline = l(:,i);
    [m n] = size(im);
    t = 1:n;
    m = -myline(1)/myline(2);
    q = -myline(3)/myline(2);
    plot(t,m*t+q,'r');
end
hold off

inters(:,1) = cross(l(:,1),l(:,2));
inters(:,1) = inters(:,1) / inters(3,1);
inters(:,2) = cross(l(:,3),l(:,4));
inters(:,2) = inters(:,2) / inters(3,2);

van_line = cross(inters(:,1),inters(:,2));

corr_matrix = [ 1 0 0 ; 0 1 0; van_line' ];

% [m n o] = size(im);
% 
% offset = [800 800];
%
% for y = 1:m
%     for x = 1:n
%         dest = ((inv(corr_matrix)))*[x;y;1];
%         dest = dest./dest(3)
%         corr_im(offset(1)+round(dest(2)),offset(2)+round(dest(1)),:) = im(y,x,:);
%     end
% end

tr = maketform('projective',(corr_matrix)');
corr_im = imtransform(im,tr,'FillValues', 0, 'Size', size(im));

figure; imshow(corr_im);

% hold on;
% for i = 1:4
%     myline = (inv(corr_matrix))'*l(:,i);
%     [m n] = size(im);
%     t = 1:n;
%     m = -myline(1)/myline(2);
%     q = -myline(3)/myline(2);
%     plot(t,m*t+q,'r');
% end
% hold off

set(gca,'YDir','normal');
set(gca,'XDir','reverse');