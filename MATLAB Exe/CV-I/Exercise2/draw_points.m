function r = draw_points(x_inh)

[m,n] = size(x_inh);
if n ~= 1|| m ~= 2
    disp('incorrect parameter dimension; maybe it is not a column vector?')
    return
end

x = -100:10:100;

plot3(x_inh(1)*x, x_inh(2)*x,x,'r'); grid on; zlabel('z'); ylabel('y'); xlabel('x');