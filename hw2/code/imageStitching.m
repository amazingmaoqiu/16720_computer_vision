function [panoImg] = imageStitching(img1, img2, H2to1)
%
% INPUT
% Warps img2 into img1 reference frame using the provided warpH() function
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear
%         equation
%
% OUTPUT
% Blends img1 and warped img2 and outputs the panorama image
img1 = im2double(img1);
img2 = im2double(img2);
left_up2   = [1;1;1];
left_down2 = [1;size(img2,1);1];
right_up2  = [size(img2,2);1;1];
right_down2= [size(img2,2);size(img2,1);1];
original_cor2 = [left_up2,left_down2,right_up2,right_down2];
% new_cor2 = floor(H2to1*original_cor2);
new_cor2 = H2to1*original_cor2;
new_cor2 = floor(new_cor2./new_cor2(3,:));
left_up1   = [1;1;1];
left_down1 = [1;size(img1,1);1];
right_up1  = [size(img1,2);1;1];
right_down1= [size(img1,2);size(img1,1);1];
cor1 = [left_up1,left_down1,right_up1,right_down1];
new_cor = [cor1,new_cor2];
w1 = max(new_cor2(1,:)) - min(new_cor2(1,:));
h1 = max(new_cor2(2,:)) - min(new_cor2(2,:));
total_width = max(new_cor(1,:)) - min(new_cor(1,:));
total_height = max(new_cor(2,:)) - min(new_cor(2,:));
panoImg = zeros(total_height,total_width);
out_size = [total_height + 10,total_width + 10];
% out_size =[h1,w1];
fill_value = 0;
warp_img1 = warpH(img1,[1,0,0;0,1,0;0,0,1],out_size,fill_value);
mask1 = zeros(size(img1,1), size(img1,2));
mask1(1,:) = 1; mask1(end,:) = 1; mask1(:,1) = 1; mask1(:,end) = 1;
mask1 = bwdist(mask1, 'city');
mask1 = mask1/max(mask1(:));
mask1 = warpH(mask1, [1,0,0;0,1,0;0,0,1], out_size,fill_value);
warp_img1 = warp_img1.*mask1;

warp_img2 = warpH(img2, H2to1, out_size,fill_value);
mask2 = zeros(size(img2,1), size(img2,2));
mask2(1,:) = 1; mask2(end,:) = 1; mask2(:,1) = 1; mask2(:,end) = 1;
mask2 = bwdist(mask2, 'city');
mask2 = mask2/max(mask2(:));
mask2 = warpH(mask2, H2to1, out_size,fill_value);
warp_img2 = warp_img2.*mask2;
% size(warp_img2)
% imshow(warp_img2);
panoImg = warp_img1 + warp_img2;
mask = mask1 + mask2;
panoImg = panoImg./mask;
% panoImg(1:size(img1,1),1:size(img1,2),:) = (panoImg(1:size(img1,1),1:size(img1,2),:) + img1)/2;
% for i=1:1:size(img1,1)
%     for j = 1:1:size(img1,2)
%         if(panoImg(i,j,:) == 0)
%             panoImg(i,j,:) = panoImg(i,j,:) + img1(i,j,:);
%         else
%             panoImg(i,j,:) = (panoImg(i,j,:) + img1(i,j,:))/2;
%         end
%     end
% end
% blender = vision.AlphaBlender('Operation','MaskSource','Input port');
% x1 = min(new_cor(1,:));
% y2 = min(new_cor(2,:));
% M = [1,0,1-x1;0,1,1-y2;0,0,1];

% overlap_area = 

imshow(panoImg);


end



