% your code here
clear all;
load('../data/sylvseq.mat');
load('../data/sylvbases.mat');
rect = zeros(1,4,size(frames,3));
rect(:,:,1) = [102,62,156,108]';
for i=2:size(frames,3)
    x = zeros(1,5);
    y = zeros(1,5);
    curr_img = frames(:,:,i-1);
    last_img = frames(:,:,i);
    [dp_x,dp_y] = LucasKanadeBasis(last_img, curr_img, rect(:,:,i-1),bases);
%     [dp_x1,dp_y1] = LucasKanade(last_img, curr_img, rect(:,:,i-1));
    rect(1,1:4,i) = rect(1,1:4,i-1) - [dp_x,dp_y,dp_x,dp_y];
    x = [rect(1,1,i),rect(1,3,i),rect(1,3,i),rect(1,1,i),rect(1,1,i)];
    y = [rect(1,2,i),rect(1,2,i),rect(1,4,i),rect(1,4,i),rect(1,2,i)];
    imshow(frames(:,:,i-1));
    hold on;
    plot(x,y,'g','LineWidth',2);
    hold off;
    pause(0.1);
end
rects(:,:) = rect(1,:,:);
rects = rects';
hold off;