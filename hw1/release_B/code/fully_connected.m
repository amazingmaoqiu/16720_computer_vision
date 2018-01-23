function [y] = fully_connected(x,W,b)
    y = zeros(1,1,size(b,1));
     x = x(:);
%     height = size(x,1);
%     width = size(x,2);
%     depth = size(x,3);
%     x1 = zeros(height*depth,width);
%     for i = 1:1:depth
%         x1((i-1)*height+1:i*height,:) = x(:,:,i);
%     end
%     x1 = x1(:);
    y(1,1,:) = W*x+b;
end
