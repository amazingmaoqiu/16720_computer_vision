function [panoImg] = imageStitching_noClip(img1, img2, H2to1)
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
new_cor2 = H2to1*original_cor2;
new_cor2 = floor(new_cor2./new_cor2(3,:));
left_up1   = [1;1;1];
left_down1 = [1;size(img1,1);1];
right_up1  = [size(img1,2);1;1];
right_down1= [size(img1,2);size(img1,1);1];
cor1 = [left_up1,left_down1,right_up1,right_down1];
new_cor = [cor1,new_cor2];
total_width = max(new_cor(1,:)) - min(new_cor(1,:));
total_height = max(new_cor(2,:)) - min(new_cor(2,:));

x1 = min(new_cor(1,:));
y2 = min(new_cor(2,:));
M = [1,0,2-x1;0,1,2-y2;0,0,1];
new_cor1 = M*cor1;

panoImg = zeros(total_height,total_width);
out_size = [total_height + 15,total_width + 15];
fill_value = 0;
warp_img1 = warpH(img1, M      , out_size,fill_value);

mask1 = zeros(size(img1,1), size(img1,2));
mask1(1,:) = 1; mask1(end,:) = 1; mask1(:,1) = 1; mask1(:,end) = 1;
mask1 = bwdist(mask1, 'city');
mask1 = mask1/max(mask1(:));
mask1 = warpH(mask1, M      , out_size,fill_value);
warp_img1 = warp_img1.*mask1;

warp_img2 = warpH(img2, M*H2to1, out_size,fill_value);
mask2 = zeros(size(img2,1), size(img2,2));
mask2(1,:) = 1; mask2(end,:) = 1; mask2(:,1) = 1; mask2(:,end) = 1;
mask2 = bwdist(mask2, 'city');
mask2 = mask2/max(mask2(:));
mask2 = warpH(mask2, M*H2to1, out_size,fill_value);
warp_img2 = warp_img2.*mask2;


% panoImg = warp_img2;
panoImg = warp_img2 + warp_img1;
mask = mask1 + mask2;
panoImg = panoImg./mask;
% for i=min(new_cor1(2,:)):1:max(new_cor1(2,:))
%     for j = min(new_cor1(1,:)):1:max(new_cor1(1,:))
%         if(panoImg(i,j,:) == 0)
%             panoImg(i,j,:) = panoImg(i,j,:) + warp_img1(i,j,:);
%         else
%             panoImg(i,j,:) = (panoImg(i,j,:) + warp_img1(i,j,:))/2;
%         end
%     end
% end
imshow(panoImg);
end



