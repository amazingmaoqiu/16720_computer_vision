p1 = imread('p1_SSD.jpg');
figure,imshow(p1),title('original-mug,jpg');
p1Mono = rgb2gray(p1);
h = fspecial('gaussian',[3,3],1);
p1Smooth = imfilter(p1Mono,h);
figure;
cannyEdge = edge(p1Smooth,'log');
imshow(cannyEdge);