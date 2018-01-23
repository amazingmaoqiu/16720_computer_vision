function [dp_x,dp_y] = lucasKanadeCorrect(It, It1, rect1, rect_pn)

% input - image at time t, image at t+1, rectangle (top left, bot right coordinates)
% output - movement vector, [dp_x, dp_y] in the x- and y-directions.
It = im2double(It);
if size(It,3) == 3
    It = im2gray(It);
end
It1 = im2double(It1);
if size(It1,3) == 3
    It1 = im2gray(It1);
end
[fx,fy] = gradient(double(It1));
p = [(rect_pn(1) - rect1(1));(rect_pn(2) - rect1(2))];
delta_p = [10;10];
threshold = 0.5;
x1 = floor(rect1(1));
y1 = floor(rect1(2));
x2 = floor(rect1(3));
y2 = floor(rect1(4));
% A1 = fx(y1:y2,x1:x2);
% A2 = fy(y1:y2,x1:x2);
% A = double([A1(:),A2(:)]);
n = 0;

x = x1:x2;
y = y1:y2;
[X,Y] = meshgrid(x,y);
template = interp2(It,X,Y);

while(delta_p'*delta_p > threshold && n < 200)
   A1 = fx(y1+p(2):y2+p(2),x1+p(1):x2+p(1));
   A2 = fy(y1+p(2):y2+p(2),x1+p(1):x2+p(1));
   A = double([A1(:),A2(:)]);
%    b = It(y1:y2,x1:x2) - It1(y1+p(2):y2+p(2),x1+p(1):x2+p(1));
   b = template - It1(y1+p(2):y2+p(2),x1+p(1):x2+p(1));
   b = b(:);
   H = A'*A;   
   delta_p = H\(A'*b);
   p = (p + delta_p); 
   n = n + 1;
end
dp_x = (p(1));
dp_y = (p(2));
end
