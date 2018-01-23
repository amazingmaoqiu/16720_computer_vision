% your code here
clear all;
load('../data/carseq.mat');
rect1 = zeros(1,4,size(frames,3));
rect1(:,:,1) = [60,117,146,152]';
% rect_record = zeros(size(frames,3),4);
% rect_record(1,:) = [60,117,146,152];
for i=2:size(frames,3)
    x = zeros(1,5);
    y = zeros(1,5);
    curr_img = frames(:,:,i-1);
    last_img = frames(:,:,i);
    [dp_x,dp_y] = LucasKanade(last_img, curr_img, rect1(:,:,i-1));
    rect1(1,1:4,i) = rect1(1,1:4,i-1) - [dp_x,dp_y,dp_x,dp_y];
    x = [rect1(1,1,i),rect1(1,3,i),rect1(1,3,i),rect1(1,1,i),rect1(1,1,i)];
    y = [rect1(1,2,i),rect1(1,2,i),rect1(1,4,i),rect1(1,4,i),rect1(1,2,i)];
%     rect_record(i,:) = [rect(1,1,i),rect(1,2,i),rect(1,3,i),rect(1,4,i)];
    imshow(frames(:,:,i-1));
    hold on;
    plot(x,y,'y','LineWidth',2);
    hold off;
    pause(0.1);
end
rects(:,:) = rect1(1,:,:);
rects = rects';
hold off;




