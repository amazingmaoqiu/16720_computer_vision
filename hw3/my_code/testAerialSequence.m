% your code here
clear all;
load('../data/aerialseq.mat');
for i=2:size(frames,3)
    curr_img = frames(:,:,i-1);
    last_img = frames(:,:,i);
    mask = SubtractDominantMotion(last_img, curr_img);
    mask = uint8(mask);
    sum(sum(mask))
    mask = mask*255;
    img(:,:,1) = mask + curr_img;
    img(:,:,2) = curr_img;
    img(:,:,3) = curr_img;
    imshow(img);
    if(i==30 || i==60 || i==90 || i==120)
        filename = sprintf('aerial%d',i);
        print(filename,'-djpeg');
    end
    pause(0.1);
end
hold off;