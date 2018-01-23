% Q3.3:
%       1. Load point correspondences
%       2. Obtain the correct M2
%       3. Save the correct M2, p1, p2, R and P to q3_3.mat
clear;
img1 = imread('../data/im1.png');
img2 = imread('../data/im2.png');
load('../data/intrinsics.mat');
load('../data/some_corresp.mat');

% extract 8 points to run eightpoint and do the following work
% p1 = pts1(50:10:110,:);
% p2 = pts2(50:10:110,:);

M = max(size(img1,1),size(img1,2));
F_eightpoint = eightpoint(pts1,pts2,M);
% F_eightpoint = estimateFundamentalMatrix(pts1,pts2);
E_eightpoint = essentialMatrix(F_eightpoint,K1,K2);
M1 = K1*[eye(3),zeros(3,1)];
M2s = camera2(E_eightpoint);
for i = 1:4
   C2s(:,:,i) = M2s(:,:,i);
   M2s(:,:,i) = K2*M2s(:,:,i); 
end
for i=1:4
   [ P1(:,1:3,i), err(i) ] = triangulate( M1, pts1, M2s(:,:,i), pts2 ); 
   if all (P1(:,3,i) > 0)
      P = P1(:,:,i); 
      M2 = M2s(:,:,i);
      C2 = C2s(:,:,i);
   end
end
p1 = pts1;
p2 = pts2;
scatter3(P(:,1),P(:,2),P(:,3));

