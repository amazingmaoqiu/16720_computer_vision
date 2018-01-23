function buildRecognitionSystem()
% Creates vision.mat. Generates training features for all of the training images.
 	load('dictionary.mat');
 	load('../data/traintest.mat');

	% TODO create train_features
    filterBank = createFilterBank();
%     train_imagenames = train_imagenames(1:1:end);
%     train_labels = train_labels(1:1:end);
    dictionarySize = size(dictionary,2);
    layerNum = 3;
    K = size(dictionary,2);
    train_features = zeros(K*(4^layerNum-1)/3,size(train_imagenames,1));
    for i = 1:1:size(train_imagenames,1)
%         img = imread(strcat(['../data/'],train_imagenames{i,1}));
%         if(size(img,3) == 1)
%             img = repmat(img,1,1,3);
%         end
%         wordMap = getVisualWords(img,filterBank,dictionary');
        wordMap = load(strrep(strcat(['../data/'],train_imagenames{i,1}),'.jpg','.mat'));
        wordMap = wordMap.wordMap;
        train_features(:,i) = getImageFeaturesSPM(layerNum, wordMap, dictionarySize);
    end     
    
	save('vision.mat', 'filterBank', 'dictionary', 'train_features', 'train_labels');

end