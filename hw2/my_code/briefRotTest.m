% ript to test BRIEF under rotations
img = imread('../data/model_chickenbroth.jpg');
[locs, desc] = briefLite(img);
for j=1:1:9
   degree(j) = (j-1)*10;
   img1 = imrotate(img,10*(j-1));
   [locs1, desc1] = briefLite(img1);
   ratio = 0.9;
   matches = briefMatch(desc, desc1, ratio);
   figure(j);
   plotMatches(img, img1, matches, locs, locs1);
   distance = zeros(size(matches,1),1);
% for i=1:1:size(matches,1)
%    distance(i) = sum(xor(desc(matches(i,1),:), desc1(matches(i,2),:))); 
% end
% criteria = 3.0 *min(distance);
num(j) = size(matches,1); 
end

