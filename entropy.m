% Calculates the entropy given the binary_targets (vector of 0s and 1s)
% Examples
%    entropy([1 1]) => 0
%    entropy([1 0]) => 1

function [result] = entropy(binary_targets)

    % Base case and ...
    % Workaround for log2(0) = NaN when all binary_targets are the same
    if isempty(binary_targets) || all(binary_targets == binary_targets(1))
        result = 0;
        return;
    end
    
    num_positive_examples = sum(binary_targets);
    num_examples = length(binary_targets);
    
    prop_positive_examples = num_positive_examples / num_examples;
    prop_negative_examples = 1 - prop_positive_examples;
    
    result = - prop_positive_examples * log2(prop_positive_examples) ...
             - prop_negative_examples * log2(prop_negative_examples);
    
    
    
   
    
