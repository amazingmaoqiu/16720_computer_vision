function [grad_W, grad_b] = Backward(W, b, X, Y, act_h, act_a)
% [grad_W, grad_b] = Backward(W, b, X, Y, act_h, act_a) computes the gradient
% updates to the deep network parameters and returns them in cell arrays
% 'grad_W' and 'grad_b'. This function takes as input:
%   - 'W' and 'b' the network parameters
%   - 'X' and 'Y' the single input data sample and ground truth output vector,
%     of sizes Nx1 and Cx1 respectively
%   - 'act_h' and 'act_a' the network layer pre and post activations when forward
%     forward propogating the input smaple 'X'
N = size(X,1);
H = size(W{1},1);
C = size(b{end},1);
assert(size(W{1},2) == N, 'W{1} must be of size [H,N]');
assert(size(b{1},2) == 1, 'W{end} must be of size [H,1]');
assert(size(W{end},1) == C, 'W{end} must be of size [C,H]');
assert(all(size(act_a{1}) == [H,1]), 'act_a{1} must be of size [H,1]');
assert(all(size(act_h{end}) == [C,1]), 'act_h{end} must be of size [C,1]');
% assert(all(size(outputs) == [C,1]), 'output must be of size [C,1]');

% Your code here
num_layers = max(size(act_h));
grad_W = cell([num_layers,1]);
grad_b = cell([num_layers,1]);
dz = act_h{end} - Y';
dW = dz*(act_h{num_layers - 1})' + 0.1*W{end};
% dW = dz*(act_h{num_layers - 1})';
db = dz;
grad_W{end} = dW;
grad_b{end} = db;
for i=num_layers-1:-1:2
   da = W{i+1}'*dz;
   dz = (1 - act_h{i}).*act_h{i}.*da;
   dW = dz*(act_h{i - 1})' + 0.1*W{i};
%    dW = dz*(act_h{i - 1})';
   db = dz;
   grad_W{i} = dW;
   grad_b{i} = db;
end
da = W{2}'*dz;
dz = (1 - act_h{1}).*act_h{1}.*da;
dW = dz*(X)' + 0.1*W{1};
% dW = dz*(X)';
db = dz;
grad_W{1} = dW;
grad_b{1} = db;


assert(size(grad_W{1},2) == N, 'grad_W{1} must be of size [H,N]');
assert(size(grad_W{end},1) == C, 'grad_W{end} must be of size [C,N]');
assert(size(grad_b{1},1) == H, 'grad_b{1} must be of size [H,1]');
assert(size(grad_b{end},1) == C, 'grad_b{end} must be of size [C,1]');

end
