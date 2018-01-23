function locsDoG = getLocalExtrema(DoGPyramid, DoGLevels, ...
                        PrincipalCurvature, th_contrast, th_r)
%%Detecting Extrema
% INPUTS
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
% DoG Levels  - The levels of the pyramid where the blur at each level is
%               outputs
% PrincipalCurvature - size (size(im), numel(levels) - 1) matrix contains the
%                      curvature ratio R
% th_contrast - remove any point that is a local extremum but does not have a
%               DoG response magnitude above this threshold
% th_r        - remove any edge-like points that have too large a principal
%               curvature ratio
%
% OUTPUTS
% locsDoG - N x 3 matrix where the DoG pyramid achieves a local extrema in both
%           scale and space, and also satisfies the two thresholds.
n = 1;
for i = 2:size(DoGPyramid,1)-1
    for j = 2:size(DoGPyramid,2)-1
%         temp(1:3,1:3,1:2) = DoGPyramid(i-1:i+1,j-1:j+1,1:2);
        temp = zeros(3,3);
        temp(1:3,1:3) = DoGPyramid(i-1:i+1,j-1:j+1,1);
        temp = temp(:);
        temp = [temp;DoGPyramid(i,j,2)];
        if(DoGPyramid(i,j,1) == max(temp) || DoGPyramid(i,j,1) == min(temp))
             if(abs(PrincipalCurvature(i,j,1)) < th_r && abs(DoGPyramid(i,j,1)) > th_contrast)
                locsDoG(n,1:3) = [j,i,1];
                n = n + 1;
            end
        end
    end
end

for i = 2:size(DoGPyramid,1)-1
    for j = 2:size(DoGPyramid,2)-1
        for k = 2:size(DoGPyramid,3)-1
%             temp(1:3,1:3,1:3) = DoGPyramid(i-1:i+1,j-1:j+1,k-1:k+1);
            temp = zeros(3,3);
            temp(1:3,1:3) = DoGPyramid(i-1:i+1,j-1:j+1,k);
            temp = temp(:);
            temp = [temp;DoGPyramid(i,j,k-1);DoGPyramid(i,j,k+1)];
            if(DoGPyramid(i,j,k) == max(temp) || DoGPyramid(i,j,k) == min(temp))
                if(abs(PrincipalCurvature(i,j,k)) < th_r && abs(DoGPyramid(i,j,k)) > th_contrast)
                    locsDoG(n,1:3) = [j,i,k];
                    n = n + 1;
                end
            end
        end
    end
end

 
for i = 2:size(DoGPyramid,1)-1
    for j = 2:size(DoGPyramid,2)-1
%         temp(1:3,1:3,1:2) = DoGPyramid(i-1:i+1,j-1:j+1,4:5);
        temp = zeros(3,3);
        temp(1:3,1:3) = DoGPyramid(i-1:i+1,j-1:j+1,5);
        temp = temp(:);
        temp = [temp;DoGPyramid(i,j,4)];
        if(DoGPyramid(i,j,5) == max(temp) || DoGPyramid(i,j,5) == min(temp))
                if(abs(PrincipalCurvature(i,j,5)) < th_r && abs(DoGPyramid(i,j,5)) > th_contrast)
                    locsDoG(n,1:3) = [j,i,5];
                    n = n + 1;
                end
        end
    end
end
    
end

            