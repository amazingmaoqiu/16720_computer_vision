function [y] = max_pool(x,sz)
num_row = fix(size(x,1)/sz(1));
num_col = fix(size(x,2)/sz(2));
%num_channel = size(x,3);
%y = zeros(num_row,num_col,num_channel)
%for j = 1:1:num_channel
for i = 1:1:num_row
    for j = 1:1:num_col
        y(i,j,:) = max(max(x((i-1)*sz(1)+1:i*sz(1),(j-1)*sz(2)+1:j*sz(2),:)));
    end
end
end
