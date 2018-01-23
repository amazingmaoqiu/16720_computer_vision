function [filterBank, dictionary] = getFilterBankAndDictionary(imPaths)
% Creates the filterBank and dictionary of visual words by clustering using kmeans.

% Inputs:
%   imPaths: Cell array of strings containing the full path to an image (or relative path wrt the working directory.
% Outputs:
%   filterBank: N filters created using createFilterBank()
%   dictionary: a dictionary of visual words from the filter responses using k-means.
    filterBank = createFilterBank();
    alpha = 100;
    %img = imread(imPaths{1,1});
    filter_responses = zeros(alpha*size(imPaths,1),3*size(filterBank,1));
     for i = 1:1:size(imPaths,1)
         img = imread(imPaths{i,1});
         if(size(img,3) ~= 3)
             img = repmat(img,1,1,3);
         end
         %size(img)
         filter_responses_full = extractFilterResponses(img, filterBank);
         h = size(img,1);
         w = size(img,2);
         m = randperm(h,alpha);
         n = randperm(w,alpha);
         for j = 1:1:alpha
             filter_responses(alpha*(i-1)+j,:) = filter_responses_full(m(j),n(j),:);
        end
     end
     
     K = 150;
     [~,dictionary] = kmeans(filter_responses,K,'EmptyAction','drop');
     dictionary = dictionary';    
    
  

    % TODO Implement your code here

end
