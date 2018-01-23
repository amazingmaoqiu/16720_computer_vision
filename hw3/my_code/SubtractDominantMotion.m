function mask = SubtractDominantMotion(image1, image2)

% input - image1 and image2 form the input image pair
% output - mask is a binary image of the same size
image1 = im2double(image1);
if size(image1,3) == 3
   image1 = im2gray(image1); 
end
image2 = im2double(image2);
if size(image2,3) == 3
    image2 = im2gray(image2);
end
M = LucasKanadeAffine(image1, image2);   
% M = InverseCompositionAffine(image1, image2);
image1 = warpH(image1,M,[size(image1,1),size(image1,2)]);
mask = abs(image1 - image2)/255;
threshold = 0.00065;
mask(mask<threshold) = 0;
mask(mask ~= 0) = 1;
se = strel('disk', 8);
mask = imdilate(mask, se);
mask = imerode(mask, se);
mask = medfilt2(mask);
mask = double(mask);
end
