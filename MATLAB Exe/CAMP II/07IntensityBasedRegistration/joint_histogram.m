%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calculate joint histogram of 2 images

function [histo] = joint_histogram(img1, img2)

bins = 256;

n = zeros(bins, bins);

%%% TODO:
% calculate the joint histogram of img1 and img2
%   and store it in histo

m1=min(img1(:));
M1=max(img1(:));
m2=min(img2(:));
M2=max(img2(:));

% Scale and round to fit in {0,...,L-1}
img1=round((img1-m1)*(bins-1)/(M1-m1));
img2=round((img2-m2)*(bins-1)/(M2-m2));

for i=0:bins-1
    [x y]=find(img1==i);
    siz=size(img1);
    j=sub2ind(siz,x,y);
    n(i+1,:)=hist(img2(j),0:bins-1);
end

histo = n;
