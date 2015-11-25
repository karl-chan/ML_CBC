% Accepts as parameters original x, y vectors
% Returns trained network
function [net] = create_trainrp(x, y, num_layers, list_num_hidden_neurons, ...
    num_epochs, train_idx, validation_idx, test_idx, lr, delt_inc, delt_dec)
    [x2, y2] = ANNdata(x, y);
    net = feedforwardnet(list_num_hidden_neurons);
    net = configure(net, x2, y2);
	  net.trainFcn = 'trainrp';
    net.trainParam.delt_inc = delt_inc;
    net.trainParam.delt_dec = delt_dec;
    net.numLayers = num_layers;
    net.divideFcn = 'divideind';
    net.divideParam.trainInd = train_idx;
    net.divideParam.valInd   = validation_idx;
    net.divideParam.testInd  = test_idx;
    net.trainParam.lr = lr;    
    net.trainParam.epochs = num_epochs;
    net = train(net, x2, y2);
end
