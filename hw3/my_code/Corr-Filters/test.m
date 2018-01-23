clear all;
img = imread('lena.jpg');
img = im2double(img);
if size(img,3) == 3
   img = rgb2gray(img); 
end
template = img(248:292,252:280);
% [h,w] = floor(size(img)/20);
[H,W] = size(template);
h = floor(H);
w = floor(W);
N = H*W;
n = h*w;
X = zeros(n,N);
Y = zeros(n,1);
Y(1,1) = 1;
lamda = 2;
for i =1:w
    for j = 1:h
        temp = zeros(1,n);
        img_temp = zeros(h,w);
        img_temp = circshift(template,[20*(j-1),20*(i-1)]);
        temp = img_temp(:)';
        X(w*(j-1)+i,:) = temp;
    end
end

g = ((X'*X + lamda*eye(N))^-1)*X'*Y;

