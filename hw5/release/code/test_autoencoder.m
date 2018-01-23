% load('net.mat');
load('../data/nist36_test.mat');
data = reshape(test_data',[32,32,1,size(test_data,1)]);
autoencoders = predict(net, data);
autoencoders = double(autoencoders);
answer = psnr(data,autoencoders);