function [dp_x,dp_y] = LucasKanadeBasis(It, It1, rect, bases)

% input - image at time t, image at t+1, rectangle (top left, bot right
% coordinates), bases 
% output - movement vector, [dp_x,dp_y] in the x- and y-directions.
It = im2double(It);
if size(It,3) == 3
    It = im2gray(It);
end
It1 = im2double(It1);
if size(It1,3) == 3
    It1 = im2gray(It1);
end
[fx,fy] = gradient(double(It1));
p = [0;0];
delta_p = [100;100];
threshold = 0.5;
x1 = floor(rect(1));
y1 = floor(rect(2));
x2 = floor(rect(3));
y2 = floor(rect(4));
k = size(bases,3);
B = zeros(numel(bases(:,:,1)),k);
for i=1:k
    B_temp = zeros(numel(bases(:,:,1)),1);
    B_temp = bases(:,:,i);
    B_temp = B_temp(:);
    B(:,i) = B_temp;
end

% A1 = fx(y1:y2,x1:x2);
% A2 = fy(y1:y2,x1:x2);
% A = double([A1(:),A2(:)]);
n = 0;
while(delta_p'*delta_p > threshold && n < 200)
   A1 = fx(y1+p(2):y2+p(2),x1+p(1):x2+p(1));
   A2 = fy(y1+p(2):y2+p(2),x1+p(1):x2+p(1));
   A = double([A1(:),A2(:)]);
   
   A = A - B*B'*A;
   
   b = It(y1:y2,x1:x2) - It1(y1+p(2):y2+p(2),x1+p(1):x2+p(1));
   b = b(:);
   
   b = b - B*B'*b;
   
   H = A'*A;   
   delta_p = H\(A'*b);
   p = p + delta_p; 
   n = n + 1;
end
dp_x = p(1);
dp_y = p(2);
end
