function r = draw_ideal(idpoint)

if idpoint(3) ~= 0
    disp('this function displays ideal points');
end

hold on;
draw_lines([0 0 1]);
plot3(idpoint(1),idpoint(2),0,'rx');
hold off;
grid on;
