function [ F ] = ransacF( pts1, pts2, M )
% ransacF:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q5.1:
%     Implement RANSAC
%     Generate a matrix F from some '../data/some_corresp_noisy.mat'
%          - using eightpoint
%          - using ransac

%     In your writeup, describe your algorithm, how you determined which
%     points are inliers, and any other optimizations you made
n = size(pts1,1);
threshold = 0.01;
max_number_inliers = 0;
smallest_error = 0;
pts1 = [pts1,ones(n,1)];
pts2 = [pts2,ones(n,1)];
for i=1:50
   temp = randperm(n);
   order = temp(1:7);
   p1 = pts1(order,:);
   p2 = pts2(order,:);
   F_temp = sevenpoint(p1,p2,M);
   for i=1:size(F_temp,1)
      error = abs(diag(pts1*F_temp{i}*pts2'));
      inliers_temp = find(error < threshold);
      numberOfInliers = numel(inliers_temp);
      if(numberOfInliers > max_number_inliers || (numberOfInliers == max_number_inliers && sum(error) < smallest_error))
          max_number_inliers = numberOfInliers;
          smallest_error = sum(error);
          F = F_temp{i};
          inliers = inliers_temp;
       end 
   end
end
% clear p1 p2;
% p1 = [pts1(inliers,:),ones(max_number_inliers,1)];
% p2 = [pts2(inliers,:),ones(max_number_inliers,1)];
% F = sevenpoint(p1,p2,M);
end

