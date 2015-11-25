% Accepts as parameters original x, y vectors
% Returns trained network
function [net] = create_traingda(x, y, num_layers, list_num_hidden_neurons, ...
    num_epochs, train_idx, validation_idx, test_idx, lr, inc, dec)
    [x2, y2] = ANNdata(x, y);
    net = feedforwardnet(list_num_hidden_neurons);
    net = configure(net, x2, y2);
    net.numLayers = num_layers;
    net.divideFcn = 'divideind';
    net.divideParam.trainInd = train_idx;
    net.divideParam.valInd   = validation_idx;
    net.divideParam.testInd  = test_idx;
    net.trainFcn = 'traingda';
    net.trainParam.epochs = num_epochs;
    net.trainParam.lr = lr;
    net.trainParam.lr_inc = inc;
    net.trainParam.lr_dec = dec;
    net = train(net, x2, y2);
end