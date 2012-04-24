function r = draw_infinity_intersection(line)

if (nargin ~= 1) || (sum(size(line) ~= [3 1]))
    disp('please enter a column vector containing the homogeneous representation of a line');
    return;
end

line_inf = [0;0;1];

%intersection = cross(line,line_inf);
intersection = [line(2),-line(1),0];

par_to_draw = 5;
parallels(3,:) = randi(10,1,par_to_draw);
parallels(1,:) = line(1);
parallels(2,:) = line(2);

hold on;
draw_lines(line_inf);
draw_lines(line);
for i = 1:par_to_draw
    draw_lines(parallels(:,i));
end     
draw_ideal(intersection);
hold off;