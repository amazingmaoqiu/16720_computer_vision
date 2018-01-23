num_epoch = 5;
% num_epoch = 300;
classes = 36;
% layers = [32*32, 400, classes];
learning_rate = 0.01;

load('../data/nist36_train.mat', 'train_data', 'train_labels')
load('../data/nist36_test.mat', 'test_data', 'test_labels')
load('../data/nist36_valid.mat', 'valid_data', 'valid_labels')

% m = size(train_data,1);
% miu = sum(train_data,1)/m;
% train_data = train_data - repmat(miu,[m,1]);
% theta2 = 1/m*sum(train_data.*train_data,1);
% train_data = train_data./repmat(theta2,[m,1]);
% valid_data = valid_data - repmat(miu,[size(valid_data,1),1]);
% valid_data = valid_data./repmat(theta2,[size(valid_data,1),1]);
% train_data = train_data(1:10:10791,:);
% train_labels = train_labels(1:10:10791,:);
% valid_data = valid_data(50:50:3600,:);
% valid_labels = valid_labels(50:50:3600,:);


index = randperm(size(train_data,1));
train_data = train_data(index,:);
train_labels = train_labels(index,:);


load('../data/nist26_model_60iters.mat');

tmpw = W{end};
tmpb = b{end};
W{end} = randn(36,800);
b{end} = randn(36,1);
W{end}(1:26,1:800) = tmpw;
b{end}(1:26) = tmpb;
% [W, b] = InitializeNetwork(layers);
train_accuracy = zeros(1,num_epoch);
valid_accuracy = zeros(1,num_epoch);
train_losses = zeros(1, num_epoch);
valid_losses = zeros(1, num_epoch);
for j = 1:num_epoch
    [W, b] = Train(W, b, train_data, train_labels, learning_rate);

    [train_acc, train_loss] = ComputeAccuracyAndLoss(W, b, train_data, train_labels);
    [valid_acc, valid_loss] = ComputeAccuracyAndLoss(W, b, valid_data, valid_labels);


    fprintf('Epoch %d - accuracy: %.5f, %.5f \t loss: %.5f, %.5f \n', j, train_acc, valid_acc, train_loss, valid_loss)
    train_accuracy(1,j) = train_acc;
    valid_accuracy(1,j) = valid_acc;
    train_losses(1,j) = train_loss;
    valid_losses(1,j) = valid_loss;
end
figure(1);
plot([0:num_epoch],[0,train_accuracy],'r');
hold on;
plot([0:num_epoch],[0,valid_accuracy],'b');
hold on;
xlabel('epoch');
ylabel('accuracy');
legend('train','valid');


figure(2);
plot([0:num_epoch],[0,train_loss],'r');
hold on;
plot([0:num_epoch],[0,valid_loss],'b');
hold on;
xlabel('epoch');
ylabel('loss');
legend('train','valid');
% save('nist36_model_1.mat', 'W', 'b')
