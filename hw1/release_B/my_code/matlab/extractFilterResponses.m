function [filterResponses] = extractFilterResponses(img, filterBank)
% Extract filter responses for the given image.
% Inputs: 
%   img:                a 3-channel RGB image with width W and height H
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W x H x N*3 matrix of filter responses
%img = imread('../data/kitchen/sun_aaebjpeispxohmfv.jpg');



% TODO Implement your code here
img = double(img);
img = RGB2Lab(img);
filterResponses = zeros(size(img,1),size(img,2),3*size(filterBank,1));
for i = 1:1:size(filterBank,1)
    h = filterBank{i,1};
    filterResponses(:,:,3*i-2:3*i) = imfilter(img(:,:,1:3),h);
end

end
