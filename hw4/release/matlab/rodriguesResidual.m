function residuals = rodriguesResidual(K1, M1, p1, K2, p2, x)
% rodriguesResidual:
% Inputs:
%   K1 - 3x3 camera calibration matrix 1
%   M1 - 3x4 projection matrix 1
%   p1 - Nx2 matrix of (x, y) coordinates
%   K2 - 3x3 camera calibration matrix 2
%   p2 - Nx2 matrix of (x, y) coordinates
%   x - (3N + 6)x1 flattened concatenation of P, r_2 and t_2

% Output:
%   residuals - 4Nx1 vector
n = size(p1,1);
X = x(1:3*n);
X = reshape(X,[n,3]);
X = [X,ones(n,1)];
p1_hat = (K1*M1*X')';
p1_hat = p1_hat./p1_hat(:,3);
r2 = x(3*n+1:3*n+3);
R2 = rodrigues(r2);
t2 = x(3*n+4:3*n+6);
M2 = [R2,t2];
p2_hat = (K2*M2*X')';
p2_hat = p2_hat./p2_hat(:,3);
residuals = reshape([p1 - p1_hat(:,1:2); p2 - p2_hat(:,1:2)], [], 1);

end
