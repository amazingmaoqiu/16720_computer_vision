load('../data/nist36_test.mat');
load('nist36_model.mat');

% m = size(test_data,1);
% miu = sum(test_data,1)/m;
% test_data = test_data - repmat(miu,[m,1]);
% theta2 = 1/m*sum(test_data.*test_data,1);
% test_data = test_data./repmat(theta2,[m,1]);

outputs = Classify(W,b,test_data);
[~,prediction] = max(outputs, [], 2);
[~,y] = max(test_labels, [], 2);
img = zeros(36,36);
for i = 1:size(prediction,1)
   img(prediction(i,1),y(i,1))  =  img(prediction(i,1),y(i,1)) + 1;
end