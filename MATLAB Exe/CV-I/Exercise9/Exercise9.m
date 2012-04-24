function Exercise9()

im = imread('distorted.JPG');

imagesc(im);

u0 = 1509;
v0 = 1177;

fx = 3133;
fy = 3139;

k1 = -0.1916;
k2 =  0.1547;

dest = uint8(zeros(size(im)));

% for i = 1:size(im,1)
%     for j = 1:size(im,2)
%         v = size(im,1)-i;
%         u = j;
%         x = (u-u0)/(size(im,2)/2);
%         y = (v-v0)/(size(im,1)/2);
%         dist = k1*(x^2 + y^2) + k2*(x^2 + y^2)^2;
%         u1 = u+(u-u0)*dist;
%         v1 = v+(v-v0)*dist;
%         i1 = round(size(im,1)-v1);
%         j1 = round(u1);
%         if (i1 > 0 && i1 < size(dest,1) && j1 > 0 && j1 < size(dest,2))
%             for k = 1:3
%                 dest(i,j,k) = im(i1,j1,k);
%             end
%         end
%     end
% end

for i = 1:size(im,1)
    for j = 1:size(im,2)
        v = i;
        u = j;
        x = (u-u0)/fx;
        y = (v-v0)/fy;
        dist = 1+k1*(x^2 + y^2) + k2*(x^2 + y^2)^2;
        u1 = u+(u-u0)*dist;
        v1 = v+(v-v0)*dist;
        i1 = round(v1);
        j1 = round(u1);
        if (i1 > 0 && i1 < size(dest,1) && j1 > 0 && j1 < size(dest,2))
            for k = 1:3
                dest(i,j,k) = im(i1,j1,k);
            end
        end
    end
end

[xa ya] = size(dest);
figure; imagesc(dest);
