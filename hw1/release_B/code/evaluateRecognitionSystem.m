function [conf] = evaluateRecognitionSystem()
% Evaluates the recognition system for all test-images and returns the confusion matrix

	load('vision.mat');
	load('../data/traintest.mat');

	% TODO Implement your code here
    conf = zeros(8,8); 
    for i =1:1:size(test_imagenames,1)
        guessImageName = guessImage(strcat(['../data/'],test_imagenames{i,1}));
        y = find(strcmp(mapping,guessImageName));
        x = test_labels(i,1);
        conf(x,y) = conf(x,y) + 1;
%         if x ~= y
%             guessImageName
%             strcat(['../data/'],test_imagenames{i,1})
    end      
end