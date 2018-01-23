function [conf] = deepEvaluateRecognitionSystem(net)
load('../data/traintest.mat');
load('../../fc7_training.mat');
conf = zeros(8,8); 
net = vgg16();

for i=1:1:size(test_imagenames,1)
    img = imread(strcat(['../data/'],test_imagenames{i,1}));
    if size(img,3) ~= 3
        img = repmat(img,1,1,3);
    end
    features = extractDeepFeatures(net,img);
    temp1(1,:) = features(1,1,:);
    temp2 = repmat(temp1,size(fc7_training,1),1);
    distances = -sqrt(diag((temp2 - fc7_training)*(temp2 - fc7_training)'));
    [~,position] = max(distances);
    x = train_labels(position,1);
    %x
    y = test_labels(i,1);
    conf(x,y) = conf(x,y) + 1;
end  
end