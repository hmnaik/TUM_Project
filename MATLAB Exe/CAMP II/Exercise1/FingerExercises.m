%Here are a few MATLAB finger exercises:

%clear all variables
clear all;

%close all windows
close all;

%clear the command windows
clc;

%generate a random matrix of size 5x6
A = rand(5,6)

%delete the last column of A
A(:,end) = []

%transform A into a vector
v = A(:)

%transform v back into a matrix
A = reshape(v,5,5)

%get the biggest entry of A row 1
m1 = max(A(1,:))

%get the biggest entry of A col 2
m2 = max(A(:,2))

%treat A as an image and visualize it
imshow(A);

%create another matrix B and multiply it with A
B = magic(5)
C = A * B

%multiply every entry of A with the corresponding entry of B
%the dot indicates that the operation * shall be performed componentwise 
D = A .* B

%square every entry of B
B2 = B .* B

%create a third matrix C filled with zeros
C = zeros(5);

%write the difference of the last two rows of A and B into the last
%two rows of C (note that for + and - no dot is necessary!) 
C(4:5,:) = A(4:5,:) - B(4:5,:)


