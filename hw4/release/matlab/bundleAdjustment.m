function [M2, P] = bundleAdjustment(K1, M1, p1, K2, M2_init, p2, P_init)
% bundleAdjustment:
% Inputs:
%   K1 - 3x3 camera calibration matrix 1
%   M1 - 3x4 projection matrix 1
%   p1 - Nx2 matrix of (x, y) coordinates
%   K2 - 3x3 camera calibration matrix 2
%   M2_init - 3x4 projection matrix 2
%   p2 - Nx2 matrix of (x, y) coordinates
%   P_init: Nx3 matrix of 3D coordinates
%
% Outputs:
%   M2 - 3x4 refined from M2_init
%   P - Nx3 refined from P_init
n = size(p1,1);
% R2 = M2_init(1:3,1:3);
% t2 = M2_init(:,end);
% r2 = invRodrigues(R2);
% x  = zeros(3*n+6,1);
% x(1:3*n,1) = P_init(:);
% x(3*n+1:3*n+3,1) = r2;
% x(3*n+4:3*n+6,1) = t2;
% residuals = rodriguesResidual(K1, M1, p1, K2, p2, x);
criterial = zeros(4*n,1);
% [residuals] = test_fun(n, M2_init, K1,M1,p1,K2,p2, P_init)
fun = @(M2)test_fun(n, M2, K1,M1,p1,K2,p2, P_init) - criterial;
M2 = lsqnonlin(fun, M2_init);
C1 = K1*M1;
C2 = K2*M2;
[ P, ~ ] = triangulate( C1, p1, C2, p2 );
end
