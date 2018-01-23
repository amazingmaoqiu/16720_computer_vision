function [lines, bw] = findLetters(im)
% [lines, BW] = findLetters(im) processes the input RGB image and returns a cell
% array 'lines' of located characters in the image, as well as a binary
% representation of the input image. The cell array 'lines' should contain one
% matrix entry for each line of text that appears in the image. Each matrix entry
% should have size Lx4, where L represents the number of letters in that line.
% Each row of the matrix should contain 4 numbers [x1, y1, x2, y2] representing
% the top-left and bottom-right position of each box. The boxes in one line should
% be sorted by x1 value.


%Your code here
img = im2double(im);
img = rgb2gray(img);
h   = fspecial('gaussian',5,1.5);
% img = integralImage(img);
% h = integralKernel([1 1 7 7], 1/49);
% img = integralFilter(img,h);
img = imfilter(img,h);
% img = imgaussfilt(img,2);
img = img < 0.465;
cc = bwconncomp(img);
height = size(img,1);
width  = size(img,2);
num_PixelList = size(cc.PixelIdxList,2);
num_positive = 1;
for i =1:num_PixelList
    if(size(cc.PixelIdxList{i},1) > 30)
        pos = cc.PixelIdxList{i};
        x11 = min(floor(pos/height)) + 1;
        x11 = max(1,x11 - 10);
        y11 = min(rem(pos,height)) + 1;
        y11 = max(0,y11 - 10);
        x22 = max(floor(pos/height)) + 1;
        x22 = min(width,x22 + 10);
        y22 = max(rem(pos,height)) + 1;
        y22 = min(height, y22 + 10);
        if((abs(x11 - x22) > 45 || abs(y11 - y22) > 45) && abs(x11 - x22) < 0.5*width && abs(y11 - y22) < 0.5*height)
            x1(num_positive) = x11;
            y1(num_positive) = y11;
            x2(num_positive) = x22;
            y2(num_positive) = y22;
            num_positive = num_positive + 1;
        end
%         x1(num_positive) = min(floor(pos/height)) + 1;
%         y1(num_positive) = min(rem(pos,height));
%         x2(num_positive) = max(floor(pos/height)) + 1;
%         y2(num_positive) = max(rem(pos,height));
%         num_positive = num_positive + 1;
    end
end
num_positive = num_positive - 1;
imshow(img);
hold on;
% for i = 1 : num_positive
%    x11 = x1(i);
%    y11 = y1(i);
%    x22 = x2(i);
%    y22 = y2(i);
%    plot([x11,x22,x22,x11,x11],[y11,y11,y22,y22,y11],'g');
%    hold on;
% end

bw = img;
nline = 1;
% 第一个总是有问题
if(abs(x1(1) - x2(1) < 0.5*width && abs(y1(1) - y2(1)) < 0.5*height))
    lines{1} = [x1(1),y1(1),x2(1),y2(1)];
end
for i = 2 : num_positive
    state = 0;
    for j = 1: nline
%         abs(y1(i) - lines{j}(1,2))
       if(abs(y1(i) - lines{j}(1,2))/abs(y1(i) - y2(i)) < 1)
           if(lines{j}(end,3) > x1(i)  && (abs(lines{j}(end,3) - x1(i))/abs(lines{j}(end,3) - lines{j}(end,1)) > ...
                   0.4 || abs(lines{j}(end,3) - x1(i))/abs(x2(i) - x1(i)) > 0.4))
%            if(lines{j}(end,3) > x1(i) && x2(i) - lines{j}(end,3) < 0.5*(x2(i) - x1(i)))
              lines{j}(end,1) = min(lines{j}(end,1),x1(i));
              lines{j}(end,2) = min(lines{j}(end,2),y1(i));
              lines{j}(end,3) = max(lines{j}(end,3),x2(i));
              lines{j}(end,4) = max(lines{j}(end,4),y2(i));
           else
               lines{j}(size(lines{j},1)+1,:) = [x1(i),y1(i),x2(i),y2(i)];
           end
           state = 1;
           break;
       end
    end
    if state ==0
        nline = nline + 1;
        lines{nline} = [x1(i),y1(i),x2(i),y2(i)];
    end
end

for i=1:nline
   lines{i} = sortrows(lines{i},1); 
end
% for i=1:nline
%    for j = 1:size(lines{i},1)-1
%        if(lines{i}(j,3) > lines{i}(j+1,1) && )
%    end
% end
for i = nline - 1:-1:1
   for j = 1:i
      if(lines{j}(1,4) > lines{j+1}(1,4))
      temp = lines{j};
      lines{j} = lines{j+1};
      lines{j+1} = temp;
      end
   end
end

count = 1;

for i = 1:size(lines,2)
   if(size(lines{i},1) > 3)
      temp2{count} = lines{i};
      count = count + 1;
   end
end
clear lines;
lines = temp2;

nline = size(lines,2);
for k = 1:nline
    for i=1:size(lines{k},1)
        x11 = lines{k}(i,1);
        y11 = lines{k}(i,2);
        x22 = lines{k}(i,3);
        y22 = lines{k}(i,4);
        plot([x11,x22,x22,x11,x11],[y11,y11,y22,y22,y11],'g');
        hold on;
    end
end

assert(size(lines{1},2) == 4,'each matrix entry should have size Lx4');
assert(size(lines{end},2) == 4,'each matrix entry should have size Lx4');
lineSortcheck = lines{1};
assert(issorted(lineSortcheck(:,1)) | issorted(lineSortcheck(end:-1:1,1)),'Matrix should be sorted in x1');

end
