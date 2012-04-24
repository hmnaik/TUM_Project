function res = scale(img)

if (ndims(img) == 2)
    minimum = min(min(img));
    maximum = max(max(img));
elseif (ndims(img) == 3)
    minimum = min(min(min(img)));
    maximum = max(max(max(img)));   
end

img = img - minimum;
res = img / (maximum-minimum);
