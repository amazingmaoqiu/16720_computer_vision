function [W, b] = Train(W, b, train_data, train_label, learning_rate)
% [W, b] = Train(W, b, train_data, train_label, learning_rate) trains the network
% for one epoch on the input training data 'train_data' and 'train_label'. This
% function should returned the updated network parameters 'W' and 'b' after
% performing backprop on every data sample.
[~,N] = size(train_data);
[~,C] = size(train_label);
assert(size(W{1},2) == N, 'W{1} must be of size [~,N]');
assert(size(b{1},2) == 1, 'b{1} must be of size [~,1]');
assert(size(b{end},2) == 1, 'b{end} must be of size [~,1]');
assert(size(W{end},1) == C, 'W{end} must be of size [C,~]');


% This loop template simply prints the loop status in a non-verbose way.
% Feel free to use it or discard it
% iterations = size(train_data,1);
% grad_W = cell(size(W));
% grad_b = cell(size(b));
% for i=1:size(W,1)
%    grad_W{i} = zeros(size(W{i}));
%    grad_b{i} = zeros(size(b{i}));
% end
% for i=1:iterations
%    X = train_data(i,:)';
%    Y = train_label(i,:);
%    [~, act_h, act_a] = Forward(W, b, X);
%    [per_grad_W, per_grad_b] = Backward(W, b, X, Y, act_h, act_a);
%    for j=1:size(W,1)
%       grad_W{j} = grad_W{j} + per_grad_W{j}/iterations;
%       grad_b{j} = grad_b{j} + per_grad_b{j}/iterations; 
%    end
% end
% [W, b] = UpdateParameters(W, b, grad_W, grad_b, learning_rate);



num_samples = size(train_data,1);
batch_size = 500;
iterations = floor(num_samples/batch_size);
last_batch = num_samples - iterations*batch_size;
grad_W = cell(size(W));
grad_b = cell(size(b));
for i=1:max(size(W))
   grad_W{i} = zeros(size(W{i}));
   grad_b{i} = zeros(size(b{i}));
end
for k = 1:iterations
    for i=1:batch_size
        X = train_data((k-1)*batch_size + i,:)';
        Y = train_label((k-1)*batch_size + i,:);
        [~, act_h, act_a] = Forward(W, b, X);
        [per_grad_W, per_grad_b] = Backward(W, b, X, Y, act_h, act_a);
        for j=1:size(W,1)
            grad_W{j} = grad_W{j} + per_grad_W{j}/batch_size;
            grad_b{j} = grad_b{j} + per_grad_b{j}/batch_size;
        end
    end
    [W, b] = UpdateParameters(W, b, grad_W, grad_b, learning_rate);
end
for i=1:last_batch
   X = train_data(iterations*batch_size + i,:)';
   Y = train_label(iterations*batch_size + i,:);
   [~, act_h, act_a] = Forward(W, b, X);
   [per_grad_W, per_grad_b] = Backward(W, b, X, Y, act_h, act_a);
   for j=1:size(W,1)
      grad_W{j} = grad_W{j} + per_grad_W{j}/last_batch;
      grad_b{j} = grad_b{j} + per_grad_b{j}/last_batch; 
   end
end
[W, b] = UpdateParameters(W, b, grad_W, grad_b, learning_rate);







% for i = 1:size(train_data,1)
% 
% 
% 
%     if mod(i, 100) == 0
%         fprintf('\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b')
%         fprintf('Done %.2f %%', i/size(train_data,1)*100)
%     end
% end
% fprintf('\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b')


end
