function [text] = extractImageText(fname)
% [text] = extractImageText(fname) loads the image specified by the path 'fname'
% and returns the next contained in the image as a string.
load('nist36_model.mat')
img = imread(fname);
table = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s', ...
         't','u','v','w','x','y','z','0','1','2','3','4','5','6','7','8','9'];
[lines, bw] = findLetters(img);
str_len = 1;
for i = 1:size(lines,2)
    for j = 1 : size(lines{i},1)
       x1 = lines{i}(j,1);
       y1 = lines{i}(j,2);
       x2 = lines{i}(j,3);
       y2 = lines{i}(j,4);
       tmp = double(bw(y1:y2,x1:x2));
       tmp1 = imresize(tmp,[32,32]);
       tmp2 = 1 - tmp1(:);
       test_data = tmp2(:);
       [output] = Classify(W,b,test_data');
       [~,prediction] = max(output,[],2);
       text(str_len) = table(prediction);
       str_len = str_len + 1;
    end
    test(str_len) = ';';
    str_len = str_len + 1;
end

end
