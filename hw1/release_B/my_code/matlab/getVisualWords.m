function [wordMap] = getVisualWords(img, filterBank, dictionary)
% Compute visual words mapping for the given image using the dictionary of visual words.

% Inputs:
% 	img: Input RGB image of dimension (h, w, 3)
% 	filterBank: a cell array of N filters
% Output:
%   wordMap: WordMap matrix of same size as the input image (h, w)

    % TODO Implement your code here
   
%     wordMap = zeros(size(img,1),size(img,2),3*size(filterBank,1));
    if(size(img,3) == 1)
        img = repmat(img,1,1,3);
    end
    wordMap = zeros(size(img,1),size(img,2));
    temp = zeros(1,3*size(filterBank,1));
    filterResponses = extractFilterResponses(img, filterBank);
    for i =1:1:size(img,1)
        for j =1:1:size(img,2)
            temp(1,:) = filterResponses(i,j,:);
            distance = pdist2(temp,dictionary');
            min_dist = min(distance);
            [~,position] = find(min_dist == distance);
%             wordMap(i,j,:) = dictionary(position,:);
            wordMap(i,j) = position;
        end
    end
end
