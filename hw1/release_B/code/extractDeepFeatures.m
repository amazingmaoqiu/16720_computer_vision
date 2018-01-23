function [features] = extractDeepFeatures(net,I)
    I = imresize(I,[224 224]);
    for i = 1:1:41
        if(net.Layers(i).Name(1:2) == 'fc')
            img_temp = fully_connected(img_temp,net.Layers(i).Weights,net.Layers(i).Bias);
        elseif(net.Layers(i).Name(1:4) == 'conv')
            img_temp = multichannel_conv2(img_temp,net.Layers(i).Weights,net.Layers(i).Bias);
        elseif(net.Layers(i).Name(1:4) == 'relu')
            if(net.Layers(i).Name(1:5) == 'relu7')
                break;
            end
            img_temp = ReLU(img_temp);
        elseif(net.Layers(i).Name(1:4) == 'pool')
            img_temp = max_pool(img_temp,net.Layers(i).PoolSize);
        elseif(net.Layers(i).Name(1:4) == 'prob')
        elseif(net.Layers(i).Name(1:5) == 'input')
            m = activations(net,zeros(224,224,3),'input','OutputAs','channels');
            img_temp = mean_remove(I,m);
        else
        end
    end
    features = img_temp;
end