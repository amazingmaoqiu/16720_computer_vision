function [R,t] = compute_extrinsics(K,H)
H1 = inv(K)*H;
[U,L,V] = svd(H1(:,1:2));
R = U*[1,0;0,1;0,0]*V';
R(:,3) = cross(R(:,1),R(:,2));
if det(R) == -1
    R(:,3) = -1.0*R(:,3);
end
lamda = sum(sum(H1(:,1:2)./R(:,1:2)))/6;
t = (H1(:,3))'/lamda;
end
