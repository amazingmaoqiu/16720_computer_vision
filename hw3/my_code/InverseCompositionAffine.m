function M = InverseCompositionAffine(It, It1)

% input - image at time t, image at t+1
% output - M affine transformation matrix

It = im2double(It);
if size(It,3) == 3
    It = im2gray(It);
end
It1 = im2double(It1);
if size(It1,3) == 3
    It1 = im2gray(It1);
end
[fx,fy] = gradient(double(It));
p = zeros(6,1);
delta_p = [1,1,1,1,1,1];
threshold = 0.5;
[x1,y1] = meshgrid(1:size(It,2),1:size(It,1));
x1 = x1(:);
y1 = y1(:);
n = 0;
M = eye(3);
fx = fx(:);
fy = fy(:);
A = [x1.*fx y1.*fx fx x1.*fy y1.*fy fy];
H = A'*A;   

while(norm(delta_p) > threshold && n < 200)
   b = It1 - It;
   b = b(:);
   delta_p = H\(A'*b);
%    p = p + delta_p; 
   delta_M = [1+delta_p(1),delta_p(2),delta_p(3);delta_p(4),1+delta_p(5),delta_p(6);0,0,1];
   M = M*inv(delta_M);
   It = warpH(It,M,[size(It,1),size(It,2)]);
%    It = M'*It;
%    M1 = affine2d(M);
%    It = imwarp(It,M1,imref2d([size(It,1),size(It,2)]));
   n = n + 1;
end


end