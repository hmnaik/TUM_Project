function res = grayscale(img) 

res = ones(size(img, 1), size(img, 2));
maximum = max(max(img(:,:,1)));

for i=1:size(res, 1)
    for j=1:size(res, 2)
        res(i, j) = double(img(i, j, 1)) / double(maximum);    
    end;
end;