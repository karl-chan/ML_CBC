% Accepts as parameters original x, y vectors
% Returns trained network
function [net] = create_network(x, y, num_layers, list_num_hidden_neurons, ...
    num_epochs, train_idx, validation_idx, test_idx)
    [x2, y2] = ANNdata(x, y);
    net = feedforwardnet(list_num_hidden_neurons);
    net = configure(net, x2, y2);
    net.trainParam.epochs = num_epochs;
    net.numLayers = num_layers;
    net.divideFcn = 'divideind';
    net.divideParam.trainInd = train_idx;
    net.divideParam.valInd   = validation_idx;
    net.divideParam.testInd  = test_idx;
    net = train(net, x2, y2);
end