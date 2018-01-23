function [locs,desc] = computeBrief(im, GaussianPyramid, locsDoG, k, ...
                                        levels, compareA, compareB)
%%Compute BRIEF feature
% INPUTS
% im      - a grayscale image with values from 0 to 1
% locsDoG - locsDoG are the keypoint locations returned by the DoG detector
% levels  - Gaussian scale levels that were given in Section1
% compareA and compareB - linear indices into the patchWidth x patchWidth image 
%                         patch and are each nbits x 1 vectors
%
% OUTPUTS
% locs - an m x 3 vector, where the first two columns are the image coordinates 
%		 of keypoints and the third column is the pyramid level of the keypoints
% desc - an m x n bits matrix of stacked BRIEF descriptors. m is the number of 
%        valid descriptors in the image and will vary
patchWidth = 9;
m = 1;
for n=1:1:size(locsDoG,1)
    row0 = locsDoG(n,2);
    col0 = locsDoG(n,1);
    if(row0 <= size(im,1) - (patchWidth-1)/2  ...
            && row0 >= 1 + (patchWidth-1)/2 ...
            && col0 <= size(im,2) - (patchWidth-1)/2 ...
            && col0 >= 1 + (patchWidth-1)/2)
        locs(m,:) = locsDoG(n,:);
        temp = im(row0-(patchWidth-1)/2:row0+(patchWidth-1)/2,col0-(patchWidth-1)/2:col0+(patchWidth-1)/2);
        for i=1:1:size(compareA,1)
            x1 = floor(compareA(i,1)/patchWidth) + 1;
            y1 = rem(compareA(i,1),patchWidth) + 1;
            x2 = floor(compareB(i,1)/patchWidth) + 1;
            y2 = rem(compareB(i,1),patchWidth) + 1;
            if(temp(x1,y1) > temp(x2,y2))
                desc(m,i) = 1;
            else
                desc(m,i) = 0;
            end
        end
        m = m + 1;
    end
end

        
        