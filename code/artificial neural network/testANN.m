% Accepts as input network (net), examples
% (x2, same format as x) and 
% combination method (combine_method) to 
% produce a vector of label predictions.
function [predictions] = testANN(net, x2, combine_method)
    out = sim(net, x2);
    predictions = combine_method(out);
end
