function R = rodrigues(r)
% rodrigues:

% Input:
%   r - 3x1 vector
% Output:
%   R - 3x3 rotation matrix
% R= [0,-1.0*r(3),r(2)
%     r(3),0 -1.0*r(1)
%     -1.0*r(2),r(1),0];
theta = sqrt(r'*r);
n     = r/theta;
expand_n = [0,-1.0*n(3),n(2)
            n(3),0 -1.0*n(1)
            -1.0*n(2),n(1),0];
R = eye(3)*cos(theta) + (1 - cos(theta))*n*n' + sin(theta)*expand_n;
end
