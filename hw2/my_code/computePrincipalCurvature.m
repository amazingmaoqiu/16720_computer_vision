function PrincipalCurvature = computePrincipalCurvature(DoGPyramid)
%%Edge Suppression
% Takes in DoGPyramid generated in createDoGPyramid and returns
% PrincipalCurvature,a matrix of the same size where each point contains the
% curvature ratio R for the corre-sponding point in the DoG pyramid
%
% INPUTS
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
%
% OUTPUTS
% PrincipalCurvature - size (size(im), numel(levels) - 1) matrix where each 
%                      point contains the curvature ratio R for the 
%                      corresponding point in the DoG pyramid
[fx,fy] = gradient(DoGPyramid);
[fxx,fxy] = gradient(fx);
[fyx,fyy] = gradient(fy);
PrincipalCurvature = (fxx + fyy).^2./(fxx.*fyy - fxy.*fyx);
%PrincipalCurvature(PrincipalCurvature<0.03) = 0;
% PrincipalCurvature(PrincipalCurvature>12  ) = 0;
end



