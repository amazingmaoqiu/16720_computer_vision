function [y] = mean_remove(x,m)
%     m = activations(net,zeros(224,224,3),'input','OutputAs','channels');
    y = single(x) + m;
end
