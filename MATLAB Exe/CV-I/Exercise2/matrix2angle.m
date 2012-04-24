function r = matrix2angle(M)

w_norm = acos((trace(M)-1)/2);

r = 1/(2*sin(w_norm)) * [ M(3,2)-M(2,3); M(1,3)-M(3,1); M(2,1)-M(1,2) ] * w_norm;
