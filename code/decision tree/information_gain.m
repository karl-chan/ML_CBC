% Given matrix of examples and specified attribute, calculate information
%   gain of that attribute.
function [gain] = information_gain(examples, attribute, binary_targets)

    % Extracts from example matrix, positive examples where attribute is 1.
    % Creates a bitmap that represents if the attribute in the row is
    %   either 1 or 0.
    positive_examples = (examples(:, attribute) == 1);
    
    % Won't this mean that positive bitmap size and negative bitmap size
    %   are the same?
    negative_examples = ~positive_examples;
    
    num_total_examples = size(examples, 1);
    num_positive_examples = sum(positive_examples);
    num_negative_examples = sum(negative_examples);
    
    positive_ratio = num_positive_examples / num_total_examples;
    negative_ratio = num_negative_examples / num_total_examples;
        
    gain = entropy(binary_targets) ...
        - positive_ratio * entropy(binary_targets(positive_examples)) ...
        - negative_ratio * entropy(binary_targets(negative_examples));
end

