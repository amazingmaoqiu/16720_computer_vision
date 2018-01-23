function [ F ] = eightpoint( pts1, pts2, M )
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save F, M, pts1, pts2 to q2_1.mat

%     Write F and display the output of displayEpipolarF in your writeup
n = size(pts1,1);
T = diag([1.0/M,1.0/M,1.0]);
pts1 = pts1/M;
pts2 = pts2/M;
pts11 = [pts1,ones(n,1)];
pts22 = [pts2,ones(n,1)];
% A =[pts11(:,1).*pts22(:,1),pts11(:,1).*pts22(:,2),pts11(:,1),pts11(:,2).*pts22(:,1), ...
%     pts11(:,2).*pts22(:,2),pts11(:,2),pts22(:,1),pts22(:,2),ones(size(pts11,1),1)];
A =[pts22(:,1).*pts11(:,1),pts22(:,1).*pts11(:,2),pts22(:,1),pts22(:,2).*pts11(:,1), ...
    pts22(:,2).*pts11(:,2),pts22(:,2),pts11(:,1),pts11(:,2),ones(size(pts11,1),1)];
[~,~,V] = svd(A);
temp = reshape(V(:,end),[3,3]);
temp = temp';
[U1,S1,V1] = svd(temp);

assist = 0.5*(S1(1,1) + S1(2,2));
S1(1,1) = assist;
S1(2,2) = assist;

S1(3,3) = 0;
F = U1*S1*(V1)';
F = refineF(F,pts11(:,1:2),pts22(:,1:2));
F = T'*F*T;


% norm1 = pts1 ./ M;
% norm2 = pts2 ./ M;
% 
% % find coordinaing points
% x1 = norm1(:,1);
% y1 = norm1(:,2);
% x2 = norm2(:,1);
% y2 = norm2(:,2);
% [n,~] = size(pts1);
% 
% % organize the coefficient matrix
% coff = [x1 .* x2, x1 .* y2, x1, y1 .* x2, y1 .* y2, y1, x2, y2, ones(n,1)];
% 
% % compute F using SVD
% [~,~,d] = svd(coff);
% F = [d(1,9),d(2,9),d(3,9);
%     d(4,9),d(5,9),d(6,9);
%     d(7,9),d(8,9),d(9,9)];
% 
% 
%  % call refineF function
%  F = refineF(F, norm1, norm2);
% 
% % normalize F
% m = [1/M,0,0;
%     0,1/M,0;
%     0,0,1];
% F = m' * F * m;


end

