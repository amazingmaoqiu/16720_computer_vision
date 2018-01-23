function [outputs, act_h, act_a] = Forward(W, b, X)
% [OUT, act_h, act_a] = Forward(W, b, X) performs forward propogation on the
% input data 'X' uisng the network defined by weights and biases 'W' and 'b'
% (as generated by InitializeNetwork(..)).
%
% This function should return the final softmax output layer activations in OUT,
% as well as the hidden layer post activations in 'act_h', and the hidden layer
% pre activations in 'act_a'.
C = size(b{end},1);
N = size(X,1);
H = size(W{1},1);
assert(size(X,2) == 1, 'X must be of size [N,1]');
assert(size(W{1},2) == N, 'W{1} must be of size [H,N]');
assert(size(b{1},2) == 1, 'W{end} must be of size [H,1]');
assert(size(W{end},1) == C, 'W{end} must be of size [C,H]');

% Your code here
num_layer = max(size(W));
act_a = cell([num_layer, 1]);
act_h = cell([num_layer, 1]);
act_a{1} = W{1}*X + b{1};
% act_h{1} = softmax(act_a{1});
act_h{1} = 1.0./(1.0 + exp(-1.0.*act_a{1}));

for i=2:num_layer-1
    act_a{i} = W{i}*act_h{i-1} + b{i};
%     act_h{i} = softmax(act_a{i});
    act_h{i} = 1.0./(1.0 + exp(-1.0.*act_a{i}));
end
act_a{num_layer} = W{num_layer}*act_h{num_layer-1} + b{num_layer};
act_h{num_layer} = softmax(act_a{num_layer});
% act_h{1} = 1.0./(1.0 + exp(-1.0.*act_a{1}));
outputs = act_h{end};

assert(all(size(act_a{1}) == [H,1]), 'act_a{1} must be of size [H,1]');
assert(all(size(act_h{end}) == [C,1]), 'act_h{end} must be of size [C,1]');
assert(all(size(outputs) == [C,1]), 'output must be of size [C,1]');
end