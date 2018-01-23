function M = LucasKanadeAffine(It, It1)

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
p = zeros(6,1);
delta_p = [1,1,1,1,1,1];
threshold = 0.5;
n=1;
while(norm(delta_p) > threshold && n < 200)
   M = [1+p(1),p(2),p(3);p(4),1+p(5),p(6);0,0,1];
%    It1 = warpH(It1,M,[size(It1,1),size(It1,2)]);
   M1 = affine2d(M);
   It1 = imwarp(It1,M1);
   b = It - It1;
   b = b(:);
   
   [fx,fy] = gradient(double(It1));
   fx = fx(:);
   fy = fy(:);
   assist = zeros(size(fx,1),1);
   A = [fx assist assist assist fy assist]; 
   
   H = A'*A;   
   delta_p = H\(A'*b);
   
%    temp(1) = p(1)+delta_p(1)+p(1)*delta_p(1)+p(3)*delta_p(2);
%    temp(1) = p(2)+delta_p(2)+p(2)*delta_p(1)+p(4)*delta_p(2);
%    temp(1) = p(3)+delta_p(3)+p(1)*delta_p(3)+p(3)*delta_p(4);
%    temp(1) = p(4)+delta_p(4)+p(2)*delta_p(3)+p(4)*delta_p(4);
%    temp(1) = p(5)+delta_p(5)+p(1)*delta_p(5)+p(3)*delta_p(6);
%    temp(1) = p(6)+delta_p(6)+p(2)*delta_p(5)+p(4)*delta_p(6);
%    p = temp;
    p = p + delta_p;
   
%    p = p + delta_p; 
%    [fx, fy] = gradient(It);
   n = n + 1;
end

end

