function [ ret ] = information_gain( examples, attribute, binary_targets )

    zero_indices = (examples(:, attribute) == 0);
    one_indices = ~zero_indices;
    
    total_count = size(examples, 1);
    one_count = sum(one_indices);
    zero_count = sum(zero_indices);
    
    ret = entropy(binary_targets) - (one_count / total_count) * entropy(binary_targets(one_indices)) - (zero_count / total_count) * entropy(binary_targets(zero_indices));
end

