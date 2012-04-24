function r = draw_image_plane(distance,vector)

if (nargin ~= 2) || (sum(size(vector) ~= [3 1]))
    disp('please enter distance of image plane from projection center and a 3-comp column vector');
    return;
end

[X,Y] = meshgrid(-100:10:10);
Z = ones(size(X)) .* distance;
hold on;
surf(X,Y,Z); % image plane
draw_points([vector(1)/vector(3);vector(2)/vector(3)]); % point
plot3(vector(1)*distance/vector(3), vector(2)*distance/vector(3),distance,'gx');
draw_lines(vector);
t = -50:1:50;
m = -(vector(1)/vector(2));
q = distance*vector(3)/vector(2);
plot3(t,(m*t)-q,ones(size(t))*distance,'r');
colormap(gray); shading flat;
hold off;