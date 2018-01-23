load('nist26_model_5.mat');
load('../data/nist26_test.mat');
load('miu&theta');


test_data = test_data - repmat(miu,[size(test_data,1),1]);
test_data = test_data./repmat(theta2,[size(test_data,1),1]);

[accuracy, loss] = ComputeAccuracyAndLoss(W, b, test_data, test_labels);