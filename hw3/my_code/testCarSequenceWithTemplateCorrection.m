% your code here
clear all;
load('../data/carseq.mat');
frames = im2double(frames);
rect = zeros(1,4,size(frames,3));
rect(:,:,1) = [60,117,146,152];
epsilon = 5.0;
for i=2:size(frames,3)
    x = zeros(1,5);
    y = zeros(1,5);
    curr_img = frames(:,:,i-1);
    last_img = frames(:,:,i);
    [dp_x,dp_y] = LucasKanade(last_img, curr_img, rect(1,1:4,i-1));
    dx = dp_x - rect(1,1,i-1) + rect(1,1,1);
    dy = dp_y - rect(1,2,i-1) + rect(1,2,1);
    [dp_x1,dp_y1] = lucasKanadeCorrect(frames(:,:,1), curr_img, rect(1,1:4,1), rect(1,1:4,i-1));
    dp_x1 = dp_x1*(-1.0);
    dp_y1 = dp_y1*(-1.0);
    pdist2([dx,dy],[dp_x1,dp_y1])
    if(pdist2([dx,dy],[dp_x1,dp_y1]) < epsilon)
         dp_x = -rect(1,1,1) + rect(1,1,i-1) + dp_x1;
         dp_y = -rect(1,2,1) + rect(1,2,i-1) + dp_y1;
    end
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



