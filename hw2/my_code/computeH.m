function H2to1 = computeH(p1,p2)
% INPUTS:
% p1 and p2 - Each are size (2 x N) matrices of corresponding (x, y)'  
%             coordinates between two images
%
% OUTPUTS:
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear 
%         equation


% for i=1:1:size(p1,2)
%     a(2*i-1,:) = [p1(1,i),p1(2,i),1,0,0,0,-1.0*p1(1,i)*p2(1,i),-1.0*p1(2,i)*p2(1,i)];
%     a(2*i,:  ) = [0,0,0,p1(1,i),p1(2,i),1,-1.0*p1(1,i)*p2(2,i),-1.0*p1(2,i)*p2(2,i)];
%     b(2*i-1,1) = p2(1,i);
%     b(2*i,1  ) = p2(2,i);
% end
% [U S V] = svd(a);
% temp = U'*b;
% h = V*(diag(diag(S).^-1)*(temp(1:8,1)));
% h = [h;1];
% H2to1 = reshape(h,[3,3])';

for i=1:1:size(p2,2)
    a(2*i-1,:) = [p2(1,i),p2(2,i),1,0,0,0,-1.0*p2(1,i)*p1(1,i),-1.0*p2(2,i)*p1(1,i)];
    a(2*i,:  ) = [0,0,0,p2(1,i),p2(2,i),1,-1.0*p2(1,i)*p1(2,i),-1.0*p2(2,i)*p1(2,i)];
    b(2*i-1,1) = p1(1,i);
    b(2*i,1  ) = p1(2,i);
end
[U S V] = svd(a);
temp = U'*b;
h = V*(diag(diag(S).^-1)*(temp(1:8,1)));
h = [h;1];
H2to1 = reshape(h,[3,3])';
end

