function [compareA, compareB] = makeTestPattern(patchWidth, nbits) 
%%Creates Test Pattern for BRIEF
%
% Run this routine for the given parameters patchWidth = 9 and n = 256 and
% save the results in testPattern.mat.
%
% INPUTS
% patchWidth - the width of the image patch (usually 9)
% nbits      - the number of tests n in the BRIEF descriptor
%
% OUTPUTS
% compareA and compareB - LINEAR indices into the patchWidth x patchWidth image 
%                         patch and are each nbits x 1 vectors. 
% compareA = zeros(nbits,1);
compareB = zeros(nbits,1);
compareA = floor((patchWidth^2-1)*random('unif',0,1,nbits,1)) + 1;
for i=1:1:nbits
    compareB(i,1) = floor((patchWidth^2-1)*random('unif',0,1)) + 1;
    while(compareB(i,1) == compareA(i,1))
        compareB(i,1) = floor((patchWidth^2-1)*random('unif',0,1)) + 1;
    end
end
end


