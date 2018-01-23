img1 = imread('../data/model_chickenbroth.jpg');
img2 = imread('../data/chickenbroth_01.jpg');
img1 = im2double(img1);
if size(img1,3)==3
    img1= rgb2gray(img1);
end
img2 = im2double(img2);
if size(img2,3)==3
    img2= rgb2gray(img2);
end
[locs1, desc1] = briefLite(img1);
[locs2, desc2] = briefLite(img2);
ratio = 0.9;
[matches] = briefMatch(desc1, desc2, ratio);

plotMatches(img1, img2, matches, locs1, locs2);