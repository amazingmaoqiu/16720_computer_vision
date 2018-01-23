function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)
% Compute histogram of visual words using SPM method
% Inputs:
%   layerNum: Number of layers (L+1)
%   wordMap: WordMap matrix of size (h, w)
%   dictionarySize: the number of visual words, dictionary size
% Output:
%   h: histogram of visual words of size {dictionarySize * (4^layerNum - 1)/3} (l1-normalized, ie. sum(h(:)) == 1)

    % TODO Implement your code here
%     h = zeros((4^layerNum-1)/9,dictionarySize);
%     weights = zeros(1,layerNum);
%     weights(1,1) = 2^(-layerNum);
%     weights(1,2) = 2^(-layerNum);
%     for i = 3:1:layerNum
%         weights(1,i) = 2*weights(1,i-1);
%     end
%     
%     for l = 1:1:layerNum
%         h1 = fix(size(wordMap,1)/(2^(l-1)));
%         w1 = fix(size(wordMap,2)/(2^(l-1)));
%         for i = 1:1:2^(l-1)
%             for j = 1:1:2^(l-1)
%                 wordMap_temp = wordMap((i-1)*h1+1:i*h1,(j-1)*w1+1:j*w1);
%                 h((4^(l-1)-1)/3+(i-1)*2^(l-1)+j,:) = getImageFeatures(wordMap_temp, dictionarySize)*weights(1,l);
%             end
%         end
%     end
%     h = h(:)/sum(h(:)');  

    h = zeros(dictionarySize,(4^layerNum-1)/3);
    weights = zeros(1,layerNum);
    weights(1,1) = 2^(1-layerNum);
    weights(1,2) = weights(1,1);
    for i=3:1:layerNum
        weights(1,i) = weights(1,i-1)*2.0;
    end
    l = layerNum;
    h1 = fix(size(wordMap,1)/(2^(l-1)));
    w1 = fix(size(wordMap,2)/(2^(l-1)));
    for i = 1:1:2^(l-1)
         for j = 1:1:2^(l-1)
             wordMap_temp = wordMap((i-1)*h1+1:i*h1,(j-1)*w1+1:j*w1);
             h(:,(4^(l-1)-1)/3+(i-1)*2^(l-1)+j) = getImageFeatures(wordMap_temp, dictionarySize)*weights(1,l);
         end
    end
    for l = layerNum-1:-1:1
        for i = 1:1:2^(l-1)
            for j = 1:1:2^(l-1)
                h(:,(4^(l-1)-1)/3+(i-1)*2^(l-1)+j) = (h(:,(4^(l)-1)/3+(2*i-2)*2^(l)+2*j-1) + ...
                                                      h(:,(4^(l)-1)/3+(2*i-1)*2^(l)+2*j-1) + ...
                                                      h(:,(4^(l)-1)/3+(2*i-2)*2^(l)+2*j  ) + ...
                                                      h(:,(4^(l)-1)/3+(2*i-1)*2^(l)+2*j  ))*weights(1,l);
            end
        end
    end
    h = h(:)/sum(h(:)); 
end