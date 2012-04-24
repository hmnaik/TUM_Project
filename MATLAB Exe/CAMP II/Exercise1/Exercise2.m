function r = Exercise2()

im = imread('mrihead.jpg');

figure(1); imshow(im);

figure(2); imagesc(im); colormap gray; axis off; axis equal;

disp('Continue?')
pause

disp('displaying upper quarter, in range 100-150')
[xdim ydim] = size(im);
imagesc(im(1:end/2, 1:end/2),[100,150]);

disp('Continue?')
pause

disp('using adapthisteq')
imenh = adapthisteq(im);
imshow(imenh);

disp('Continue?')
pause

disp('using gaussian')
myfilter = fspecial('gaussian');
imgauss = imfilter(im,myfilter,'replicate');
imshow(imgauss);

disp('Continue?')
pause

disp('displaying difference')
imdiff = double(imgauss) - double(im);
imshow(imdiff);

disp('end of exercise 2')
pause
close all