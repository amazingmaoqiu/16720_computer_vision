% TODO: load test dataset
load('net.mat');
load('../data/nist36_test.mat');
% TODO: reshape and adjust the dimensions to be in the order of [height,width,1,sample_index]
data = reshape(test_data',[32,32,1,size(test_data,1)]);
% TODO: run predict()
test_recon = predict(net, data);
test_recon = double(test_recon);
PSNR = psnr(data,test_recon);

