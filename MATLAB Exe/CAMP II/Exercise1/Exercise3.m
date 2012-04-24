function r = Exercise3()

im = imread('mrihead.jpg');

disp('manual implementation')
[dxim dyim]=grad(double(im)); D = div(dxim,dyim);
imshow(D);
disp('Continue?')
pause

disp('control image')
im2 = imfilter(double(im),[0 1 0; 1 -4 1; 0 1 0],'replicate');
imshow(im2);

disp('Continue?')
pause

disp('difference')
diff = double(im2) - double(D);
imshow(diff);

disp('sum(sum(diff))')
sum(sum(diff))

disp('end of exercise 3')
pause
close all