function r = Exercise4_4points()

clc;

im1 = imread('TUfinger01.jpg');
im2 = imread('TUfinger02.jpg');
figure(1); imshow(im1);
% disp('Please click on two points on each of two parallel lines')
% [x1,x2] = ginput(4);
figure(2); imshow(im2);
% disp('Please repeat the process with another couple of lines')
% [x1(5:8),x2(5:8)] = ginput(4);

x1 = [ 68.0000   79.0000  245.0000  241.0000
  210.0000   61.0000  205.0000  153.0000];

x2 = [

    6.0000   27.0000  193.0000  189.0000
  208.0000   52.0000  208.0000  155.0000 ];




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
            final_im(round(i + corr_im_coord(2) + vert_offset),round(j + corr_im_coord(1)+horiz_offset+13),k) = corr_im(i,j,k);
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



figure(1); imshow(im1);
figure(2); imshow(im2);
figure(3); imshow(final_im);
pause
close all;