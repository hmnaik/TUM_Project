function r = Exercise4_12points()

clc;

im1 = imread('TUfinger01.jpg');
im2 = imread('TUfinger02.jpg');
figure(1); imshow(im1);
% disp('Please click on two points on each of two parallel lines')
% [x,y] = ginput(4);
figure(2); imshow(im2);
% disp('Please repeat the process with another couple of lines')
% [x(5:8),y(5:8)] = ginput(4);


x1 = [ 69.0000   73.0000   76.0000   79.0000  101.0000  104.0000  344.0000  340.0000  325.0000  323.0000  290.0000  290.0000
  209.0000  143.0000   95.0000   60.0000   40.0000   17.0000  226.0000  207.0000  116.0000  106.0000  121.0000  112.0000];

x2 = [ 6.0000   15.0000   21.0000   26.0000   53.0000   56.0000  285.0000  282.0000  272.0000  271.0000  238.0000  239.0000
  208.0000  140.0000   87.0000   53.0000   32.0000    8.0000  235.0000  211.0000  122.0000  113.0000  126.0000  116.0000];

h = mydlt(x1,x2);

t = maketform('projective',h');
corr_im = imtransform(im1,t);

[m n o] = size(im1);
[m2 n2 o2] = size(im2);

dest_coord = [tformfwd([0,0],t),tformfwd([0,n],t); tformfwd([0,0],t),tformfwd([m,0],t)];

corr_im_coord = [0 0];
corr_im_coord(1) = min(dest_coord(1,1),dest_coord(1,3));
corr_im_coord(2) = min(dest_coord(2,2),dest_coord(2,4));

horiz_offset = 100;
vert_offset = 100;
final_im = uint8(zeros(400,500));



for i = 1:m2
    for j = 1:n2
        for k = 1:3
            final_im(round(i + corr_im_coord(2) + vert_offset),round(j + corr_im_coord(1)+horiz_offset+11),k) = corr_im(i,j,k);
        end
    end
end


for i=1:m2
    for j = 1:n2
        for k = 1:3
            final_im(i+vert_offset,j+horiz_offset,k) = final_im(i+vert_offset,j+horiz_offset,k) + im2(i,j,k);
        end
    end
end
figure(3); imshow(final_im);

pause
close all