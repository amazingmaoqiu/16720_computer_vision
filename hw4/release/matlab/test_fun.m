function [residuals] = test_fun(n, M2_init, K1,M1,p1,K2,p2, P_init)
% n = size(p1,1);
C2_init = K2\M2_init;
R2 = C2_init(1:3,1:3);
t2 = C2_init(:,end);
r2 = invRodrigues(R2);
x  = zeros(3*n+6,1);
x(1:3*n,1) = P_init(:);
x(3*n+1:3*n+3,1) = r2;
x(3*n+4:3*n+6,1) = t2;
residuals = rodriguesResidual(K1, M1, p1, K2, p2, x);
end