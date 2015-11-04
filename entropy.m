% Calculates the entropy given the binary_targets
function [result] = entropy(binary_targets)
    num_positive_examples = sum(binary_targets);
    
    prop_positive_examples = num_positive_examples / length(binary_targets);
    prop_negative_examples = 1 - prop_positive_examples;
    
    result = - prop_positive_examples * log2(prop_positive_examples) ...
             - prop_negative_examples * log2(prop_negative_examples);
    
    
    
   
    