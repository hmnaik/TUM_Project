function r = draw_lines(arg1,arg2) 

[x,y] = meshgrid(-100:10:10);

if nargin() == 2
    l = cross(arg1,arg2);
else
    % argument: line l1
    l = arg1;
end
z = (-l(1)*x - l(2)*y)/l(3);


surf(x,y,z); xlabel('x'); ylabel('y'); zlabel('z');