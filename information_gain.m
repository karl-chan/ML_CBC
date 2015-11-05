% Calculates the information gain (IG(examples, attribute))
% Examples
%   information_gain([1 0; 0 1], 1, [1, 0]) = 1
function [ ret ] = information_gain( examples, attribute, binary_targets )

    positive_examples_bitmap = (examples(:, attribute) == 1);
    negative_examples_bitmap = ~positive_examples_bitmap;
    
    total_count = size(examples, 1);
    num_positive_examples = sum(positive_examples_bitmap);
    num_negative_examples = sum(negative_examples_bitmap);
        
    ret = entropy(binary_targets) ...
        - (num_positive_examples / total_count) * entropy(binary_targets(positive_examples_bitmap)) ...
        - (num_negative_examples / total_count) * entropy(binary_targets(negative_examples_bitmap));
end

