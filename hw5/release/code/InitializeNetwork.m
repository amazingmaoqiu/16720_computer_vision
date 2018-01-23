function [W, b] = InitializeNetwork(layers)
% InitializeNetwork([INPUT, HIDDEN, OUTPUT]) initializes the weights and biases
% for a fully connected neural network with input data size INPUT, output data
% size OUTPUT, and HIDDEN number of hidden units.
% It should return the cell arrays 'W' and 'b' which contain the randomly
% initialized weights and biases for this neural network.

% Your code here
% l = size(layers,1); 
num_layer = max(size(layers));
W = cell([num_layer - 1,1]);
b = cell([num_layer - 1,1]);
for i=1:num_layer - 1
   W{i} = randn([layers(i+1),layers(i)])/sqrt(layers(i));
   b{i} = randn([layers(i+1),1]);
   W{i} = W{i}./norm(W{i});
   b{i} = b{i}./norm(b{i});
   W{i} = W{i};
   b{i} = b{i};
end
C = size(b{end},1);
assert(size(W{1},2) == 1024, 'W{1} must be of size [H,N]');
assert(size(b{1},2) == 1, 'W{end} must be of size [H,1]');
assert(size(W{end},1) == C, 'W{end} must be of size [C,H]');

end
