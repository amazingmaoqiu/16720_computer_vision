% Your code here.
X = train_data(23,:)';
Y = train_labels(23,:);
[W, b] = InitializeNetwork(layers);
[outputs, act_h, act_a] = Forward(W, b, X);
[grad_W, grad_b] = Backward(W, b, X, Y, act_h, act_a);
n = max(size(W));
epsilon = 1e-4;
for i=1:n
    [OUT, IN] = size(W{i});
    index1 = unidrnd(OUT,[30,1]);
    index2 = unidrnd(IN, [30,1]);
    for j=1:30
       W_check = W;
       W_check{i}(index1(j),index2(j)) = W_check{i}(index1(j),index2(j)) + epsilon;
       [outputs1, ~, ~] = Forward(W_check, b, X);
       loss1 = -1.0*sum(log(Y*outputs1));
       W_check{i}(index1(j),index2(j)) = W_check{i}(index1(j),index2(j)) - 2.0*epsilon;
       [outputs2, ~, ~] = Forward(W_check, b, X);
       loss2 = -1.0*sum(log(Y*outputs2));
       dW_check = (loss1 - loss2)/(2*epsilon);
       error = abs(dW_check - grad_W{i}(index1(j),index2(j)))/(double(size(dW_check,1))*2.0*epsilon);
       error = sum(error);
       assert(error < 1e-3,'the gradient_W has something wrong.');
    end
end