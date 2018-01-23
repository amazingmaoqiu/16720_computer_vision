function [ P, err ] = triangulate( C1, p1, C2, p2 )
% triangulate:
%       C1 - 3x4 Camera Matrix 1
%       p1 - Nx2 set of points
%       C2 - 3x4 Camera Matrix 2
%       p2 - Nx2 set of points

%       P - Nx3 matrix of 3D coordinates
%       err - scalar of the reprojection error

% Q3.2:
%       Implement a triangulation algorithm to compute the 3d locations
n = size(p1,1);
P = zeros(n,3);
for i=1:n
   A = zeros(4,4);
   A(1,:) = p1(i,1)*C1(3,:) - C1(1,:);
   A(2,:) = p1(i,2)*C1(3,:) - C1(2,:);
   A(3,:) = p2(i,1)*C2(3,:) - C2(1,:);
   A(4,:) = p2(i,2)*C2(3,:) - C2(2,:);
   [~,~,V] = svd(A);
   P(i,:) = V(1:3,4)'/V(4,4);
end
P_temp = [P,ones(n,1)];
P1 = P_temp*C1';
p11 = P1(:,1:2)./repmat(P1(:,3),[1,2]);
P2 = P_temp*C2';
p22 = P2(:,1:2)./repmat(P2(:,3),[1,2]);
err = sum(sum((p1 - p11).^2 + (p2 - p22).^2));
end
