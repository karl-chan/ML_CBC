% Load clean data from Matlab data (cleandata_students.mat)
% x: Nx45 array, where N = #examples, 45 represents facial action units
% y: Nx1 vector, representing labels of corresponding examples

function[tree] = decision_tree(examples_matrix, ...
                     attributes_vector, binary_targets)

% tree.op: label for node (empty for leaf node)
% tree.kids: cell array which contains subtrees (empty for leaf node)
% tree.class: label for leaf node (empty for internal node)

% If all of classifications are the same
if all(binary_targets == binary_targets(1))
    tree.op = [];
    tree.kids = [];
    tree.class = binary_targets(1);
% If there is no more attribute to test for/classify
elseif isempty(attributes_vector)
    tree.op = [];
    tree.kids = [];
    tree.class = majority_value(binary_targets);
% If none of the cases happens, branch out node according to best attribute
%   using information gain
else
    best_attribute = choose_best_decision_attribute(examples_matrix, ...
                          attributes_vector, binary_targets);
    tree.op = best_attribute;
    tree.class = [];
    tree.kids = {};
    %tree.kids(1) = left;
    %tree.kids(2) = right;
    
    attributes_vector(attributes_vector == best_attribute) = [];
    
    for value_attribute = 0:1
        indices = (examples_matrix(:, best_attribute) == value_attribute);
        examples_i = examples_matrix(indices, :);
        binary_targets_i = binary_targets(indices);
        
        if (size(examples_i, 1) == 0)
            tree = [];
            tree.op = [];
            tree.kids = [];
            tree.class = majority_value(binary_targets);
            return;
        else
            tree.kids{value_attribute + 1} = decision_tree( ...
                examples_i, attributes_vector, binary_targets_i);
        end
    end
end





