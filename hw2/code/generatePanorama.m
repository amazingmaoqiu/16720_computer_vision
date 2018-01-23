function [im3] = generatePanorama(im1,im2)
[locs1, desc1] = briefLite(im1);
[locs2, desc2] = briefLite(im2);
ratio = 0.8;
matches = briefMatch(desc2, desc1, ratio);
nIter = 5000;
tol = 3;
bestH = ransacH(matches, locs2, locs1, nIter, tol);
im3 = imageStitching_noClip(im1, im2, bestH);
imshow(im3);
end