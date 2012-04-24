function r = Exercise1()

A = [1 7 3;
	2 1 4;
	4 8 2]
	
b = [28; 13; 32]

rank(A)

disp('the matrix is full rank, the solution (if it exists) is unique')

x = A\b

disp('adding parameters')

A(4,:) = [5 1 9]
b(4) = 26

disp('solving via backslash operator')
x = A\b

disp('solving via pseudo-inverse')
Apsi = pinv(A)
x = Apsi*b

disp('solving via least squares')
Alst = inv(A'*A);
Alst = Alst * A'

x = Alst*b