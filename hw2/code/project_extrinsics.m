cor_3d = load('../data/sphere.txt');
move_cor = repmat([6.3;18.3;-1.0*cor_3d(3,1)],1,size(cor_3d,2));
cor_3d_changed = cor_3d + move_cor;
w = [0,18.2,18.2,0;0,0,26,26;1,1,1,1];
x = [483,1704,2175,67;810,781,2217,2286;1,1,1,1];
h = computeH(w,x);
k = [3043.72,0,1196;0,3043.72,1604;0,0,1];
[R,t] = compute_extrinsics(k,-h);
for i=1:1:size(cor_3d_changed,2)
   w =  cor_3d_changed(:,i);
   w1 = [w;1];
   A = [R,t'];
   x1 = A*w1;
   x1 = x1/x1(3,1);
   x(:,i) = k*x1;
end
img = imread('../data/prince_book.jpg');
imshow(img);
hold on;
xx(:,1:10) = x(:,1:10);
% plot(xx(1,:),xx(2,:),'y')
plot(x(1,:),x(2,:),'y')