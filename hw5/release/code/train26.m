% num_epoch = 15;
num_epoch = 30;
classes = 26;
layers = [32*32, 400, classes];
learning_rate = 0.01;

load('../data/nist26_train.mat', 'train_data', 'train_labels')
load('../data/nist26_test.mat', 'test_data', 'test_labels')
load('../data/nist26_valid.mat', 'valid_data', 'valid_labels')


m = size(train_data,1);
miu = sum(train_data,1)/m;
train_data = train_data - repmat(miu,[m,1]);
theta2 = 1/m*sum(train_data.*train_data,1);
train_data = train_data./repmat(theta2,[m,1]);
valid_data = valid_data - repmat(miu,[size(valid_data,1),1]);
valid_data = valid_data./repmat(theta2,[size(valid_data,1),1]);


index = randperm(size(train_data,1));
train_data = train_data(index,:);
train_labels = train_labels(index,:);

% train_data = train_data(10:10:7800,:);
% train_labels = train_labels(10:10:7800,:);
% valid_data = valid_data(100:5:2600,:);
% valid_labels = valid_labels(100:5:2600,:);

% load('nist26_model_5.mat');
[W, b] = InitializeNetwork(layers);
train_accuracy = zeros(1,num_epoch);
valid_accuracy = zeros(1,num_epoch);
train_loss = zeros(1, num_epoch);
valid_loss = zeros(1, num_epoch);
for j = 1:num_epoch
    [W, b] = Train(W, b, train_data, train_labels, learning_rate);

    [train_acc, train_loss] = ComputeAccuracyAndLoss(W, b, train_data, train_labels);
    [valid_acc, valid_loss] = ComputeAccuracyAndLoss(W, b, valid_data, valid_labels);


    fprintf('Epoch %d - accuracy: %.5f, %.5f \t loss: %.5f, %.5f \n', j, train_acc, valid_acc, train_loss, valid_loss)
    train_accuracy(1,j) = train_acc;
    valid_accuracy(1,j) = valid_acc;
    train_loss1(1,j)     = train_loss;
    valid_loss1(1,j)     = valid_loss;
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
plot([1:num_epoch],train_loss1,'r');
hold on;
plot([1:num_epoch],valid_loss1,'b');
hold on;
xlabel('epoch');
ylabel('loss');
legend('train','valid');

% save('nist26_model_6.mat', 'W', 'b');
