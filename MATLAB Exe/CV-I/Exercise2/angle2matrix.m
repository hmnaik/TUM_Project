function m = angle2matrix(A)

[m,n] = size(A);

ex = [  0   -A(3)  A(2);
       A(3)   0   -A(1);
      -A(2)  A(1)   0   ];

A_norm = sqrt(A(1)^2 + A(2)^2 + A(3)^2);

m = eye(3,3) + sin(A_norm)/A_norm*ex + (1-cos(A_norm))/A_norm^2*ex^2;


