function [ x2_temp, y2_temp ] = epipolarCorrespondence( im1, im2, F, x1, y1 )
% epipolarCorrespondence:
%       im1 - Image 1
%       im2 - Image 2
%       F - Fundamental Matrix between im1 and im2
%       x1 - x coord in image 1
%       y1 - y coord in image 1

% Q4.1:
%           Implement a method to compute (x2,y2) given (x1,y1)
%           Use F to only scan along the epipolar line
%           Experiment with different window sizes or weighting schemes
%           Save F, pts1, and pts2 used to generate view to q4_1.mat
%
%           Explain your methods and optimization in your writeup

% method 1
% im1 = rgb2gray(im1);
% im2 = rgb2gray(im2);
% p1 = [x1,y1,1]';
% epipolarLine2 = F*p1;
% epipolarLine2 = epipolarLine2/norm(epipolarLine2);
% x2_temp = max(x1 - 10,1);
% check_size = 20;
% max_distance = 25;
% mask1 = im1(y1 - check_size:y1 + check_size,x1 - check_size:x1 + check_size);
% weight = fspecial('gaussian',[2*check_size+1,2*check_size+1],check_size/2);
% min_error = 99999;
% while(x2_temp < min(x1 + 10,size(im1,2) - check_size - 1))
%    y2_temp = round(-1.0*(epipolarLine2(3) + epipolarLine2(1)*x2_temp)/epipolarLine2(2));
%    p2 = round([x2_temp;y2_temp;1]);
%    if(sqrt((x1 - x2_temp)^2 + (y1 - y2_temp)^2) > max_distance)
%        x2_temp = x2_temp+1;
%       continue; 
%    end
%    if(p2(2) > 1 + check_size && p2(2) <size(im1,1) - check_size)
%        mask2 = im2(y2_temp - check_size:y2_temp + check_size,x2_temp - check_size:x2_temp + check_size);
%        diff  = mask1 - mask2;
%        error = sum(sum(sum(abs(weight.*double(diff)))));
%        if(error < min_error)
%           min_error = error;
%           x2 = x2_temp;
%           y2 = y2_temp;
%        end
%    end
%    x2_temp = x2_temp + 1;
% end
% if(x2 && y2)
%    x2_temp = x2;
%    y2_temp = y2;
% end

% method 2
p1 = [x1; y1; 1];
epipolarline1 = F*p1;
epipolarline1 = epipolarline1/sqrt(epipolarline1(1)^2 + epipolarline1(2)^2);
epipolarline2 = [-epipolarline1(2),epipolarline1(1),epipolarline1(2)*x1-epipolarline1(1)*y1]';
temp = cross(epipolarline1,epipolarline2);  
temp = floor(temp);
searchsize = 10;
mask1 = double(im1((y1-searchsize):(y1+searchsize), (x1-searchsize):(x1+searchsize)));
min_error = 99999;
weight = fspecial('gaussian', [2*searchsize+1, 2*searchsize+1], 5);
% for j = temp(2)-25:temp(2)+25 
for i = temp(2)-25:temp(2)+25 
    mask2 = double(im2(i-searchsize:i+searchsize,temp(1)-searchsize:temp(1)+searchsize));
    dist = mask1 - mask2;
    error = sum(sum((abs(weight .* dist)))); 
    if error<min_error
        min_error = error;
        x2_temp = temp(1);
        y2_temp = i;
    end
end
end