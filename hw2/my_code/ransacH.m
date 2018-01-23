function [bestH] = ransacH(matches, locs1, locs2, nIter, tol)
% INPUTS
% locs1 and locs2 - matrices specifying point locations in each of the images
% matches - matrix specifying matches between these two sets of point locations
% nIter - number of iterations to run RANSAC
% tol - tolerance value for considering a point to be an inlier
%
% OUTPUTS
% bestH - homography model with the most inliers found during RANSAC
number = 0;
numPoint = 4;
dist_1 = 1000;
iteration = 1;
    
% while(iteration < nIter)
%     order = randi([1,size(matches,1)],numPoint,1);
%     p1 = zeros(2,numPoint);
%     p2 = zeros(2,numPoint);
%     for i=1:1:numPoint
%         n1 = matches(order(i,1),1);
%         n2 = matches(order(i,1),2);
%         p1(1:2,i) = locs1(n1,1:2)';
%         p2(1:2,i) = locs2(n2,1:2)';
%     end
%     p1 = [p1;ones(1,size(p1,2))];
%     p2 = [p2;ones(1,size(p2,2))];
%     h_temp = computeH(p1,p2);
%     index1 = matches(:,1);
%     index2 = matches(:,2);
%     p11 = locs1(index1,1:2);
%     p22 = locs2(index2,1:2);
%     p11 = [p11,ones(size(p11,1),1)];
%     p22 = [p22,ones(size(p22,1),1)];
% 
%     p22_test = h_temp*p11';
%     p22_test(3,:);
%     p22_test = p22_test./p22_test(3,:);
%     p22_test = p22_test';
%     dist = (p22 - p22_test).*(p22 - p22_test);
%     dist = sqrt(sum(dist(:,1:2),2));
%     n = size(find(dist<tol),1);
%     if(n>number)
%         bestH = h_temp;
%         number = n;
%         dist_1 = dist;
%     end
%     iteration = iteration + 1;
% end

while(iteration < nIter)
    order = randi([1,size(matches,1)],numPoint,1);
    p1 = zeros(2,numPoint);
    p2 = zeros(2,numPoint);
    for i=1:1:numPoint
        n1 = matches(order(i,1),1);
        n2 = matches(order(i,1),2);
        p1(1:2,i) = locs1(n1,1:2)';
        p2(1:2,i) = locs2(n2,1:2)';
    end
    p1 = [p1;ones(1,size(p1,2))];
    p2 = [p2;ones(1,size(p2,2))];
    h_temp = computeH(p1,p2);
    index1 = matches(:,1);
    index2 = matches(:,2);
    p11 = locs1(index1,1:2);
    p22 = locs2(index2,1:2);
    p11 = [p11,ones(size(p11,1),1)];
    p22 = [p22,ones(size(p22,1),1)];

    p11_test = h_temp*p22';
    p11_test(3,:);
    p11_test = p11_test./p11_test(3,:);
    p11_test = p11_test';
    dist = (p11 - p11_test).*(p11 - p11_test);
    dist = sqrt(sum(dist(:,1:2),2));
    n = size(find(dist<tol),1);
    if(n>number)
        bestH = h_temp;
        number = n;
        dist_1 = dist;
    end
    iteration = iteration + 1;
end

dist_1;
number;
end





