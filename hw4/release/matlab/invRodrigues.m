function r = invRodrigues(R)
% invRodrigues
% Input:
%   R: 3x3 rotation matrix
% Output:
%   r: 3x1 vector

% r = rotationMatrixToVector(R);

% theta = acos(0.5*(trace(R) - 1));
% [u, v] = eig(R);
% v = diag(v);
% v = real(v);
% pos = find(abs(v-1)<0.001);
% n = u(:,pos);
% n = n/norm(n);
% r = theta*n;
theta = acos(0.5*(trace(R) - 1));
theta = real(theta);
r_temp = [R(3,2) - R(2,3); ...
          R(1,3) - R(3,1); ...
          R(2,1) - R(1,2)];
threshold = 1e-3;
if sin(theta) >= threshold
    r = theta / (2 * sin(theta)) * r_temp;
elseif trace(R) > 1
    r = (.5 - (trace(R) - 3) / 12) * r_temp;
else
    [~, tmp1] = max(diag(R));
    tmp1 = tmp1(1);
    tmp2 = mod(tmp1, 3) + 1;
    tmp3 = mod(tmp1+1, 3) + 1;

% compute the axis vector
    s = sqrt(R(tmp1, tmp1) - R(tmp2, tmp2) - R(tmp3, tmp3) + 1);
    v = zeros(3, 1, 'like', R);
    v(tmp1) = s / 2;
    v(tmp2) = (R(tmp2, tmp1) + R(tmp1, tmp2)) / (2 * s);
    v(tmp3) = (R(tmp3, tmp1) + R(tmp1, tmp3)) / (2 * s);

    r = theta * v / norm(v);
end
end
