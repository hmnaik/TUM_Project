function r = Exercise1()

tum_mi_matches
im1 = imread('tum_mi_1.JPG');
im2 = imread('tum_mi_2.JPG');

h = robust_matching_adaptive(points1,points2);

t = maketform('projective',h');
corr_im = imtransform(im1,t);

[m n o] = size(im1);
[m2 n2 o2] = size(im2);

dest_coord = [tformfwd([0,0],t),tformfwd([0,n],t); tformfwd([0,0],t),tformfwd([m,0],t)];

corr_im_coord = [0 0];
corr_im_coord(1) = min(dest_coord(1,1),dest_coord(1,3));
corr_im_coord(2) = min(dest_coord(2,2),dest_coord(2,4));

horiz_offset = 1000;
vert_offset = 200;
final_im = uint8(zeros(800,2000));

[mc nc oc] = size(corr_im);

for i = 1:mc
    for j = 1:nc
        for k = 1:3
            final_im(round(i + corr_im_coord(2) + vert_offset),round(j + corr_im_coord(1)+horiz_offset+10),k) = corr_im(i,j,k);
        end
    end
end


for i=1:m2
    for j = 1:n2
        for k = 1:3
%             final_im(i+vert_offset,j+horiz_offset,k) = final_im(i+vert_offset,j+horiz_offset,k) + im2(i,j,k);
              final_im(i+vert_offset,j+horiz_offset,k) = im2(i,j,k);
        end
    end
end



figure(1); imshow(im1);
figure(2); imshow(im2);
figure(3); imshow(final_im);
pause
close all;