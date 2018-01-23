% Q4.2:
% Integrating everything together.
% Loads necessary files from ../data/ and visualizes 3D reconstruction
% using scatter3
clear;
load('../data/templeCoords.mat');
load('../data/intrinsics.mat');
load('../data/some_corresp.mat');
img1 = imread('../data/im1.png');
img2 = imread('../data/im2.png');

M = max(size(img1,1),size(img1,2));
F = eightpoint(pts1,pts2,M);
% F_eightpoint = eightpoint(pts1,pts2,M);
% F = ransacF(pts1,pts2,M);
n = size(x1,1);
x2 = zeros(n,1);
y2 = zeros(n,1);
for i=1:n
   [x2(i),y2(i)] = epipolarCorrespondence(img1,img2,F,x1(i),y1(i));
end

E_eightpoint = essentialMatrix(F,K1,K2);
M1 = K1*[eye(3),zeros(3,1)];
M2s = camera2(E_eightpoint);
for i = 1:4
   M2s(:,:,i) = K2*M2s(:,:,i); 
end

p1 = zeros(n,2);
p2 = zeros(n,2);
p1(:,1) = x1;
p1(:,2) = y1;
p2(:,1) = x2;
p2(:,2) = y2;

P = zeros(n,3,4);
err = zeros(4,1);

for i=1:4
   P(:,:,i) = triangulate( M1, p1,M2s(:,:,i), p2 ); 
   if all(P(:,3,i) > 0)
      P_final = P(:,:,i);
      M2 = M2s(:,:,i);
   end
end
scatter3(P_final(:,1),P_final(:,2),P_final(:,3));
C1 = K1\M1;
C2 = K2\M2;