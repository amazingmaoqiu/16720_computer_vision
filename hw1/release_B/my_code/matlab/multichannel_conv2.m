function [y] = multichannel_conv2(x,h,b)
    y = zeros(size(x,1),size(x,2),size(h,4));
     for i = 1:1:size(h,4) % number of filters, which means the number of channels for output
         for j = 1:1:size(h,3) %number of channels, which means the number of the channels for input
             h(:,:,j,i) = flip(flip(h(:,:,j,i),1),2);
             y(:,:,i) = y(:,:,i) + conv2(x(:,:,j),h(:,:,j,i),'same');
         end
         y(:,:,i) = y(:,:,i) + b(1,1,i);
     end
%     for i=1:1:size(h,4)
%         for j=1:1:size(h,3)
%             x1 = x(:,:,j);
%             h1 = h(:,:,j,i);
%             y(:,:,i) = y(:,:,1) + reshape(conv2(x1(:),h1,'same'),[size(x,1),size(x,2)]);
%         end
%         y(:,:,i) = y(:,:,i) + b(i);
%     end
end
