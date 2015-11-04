% Load clean data from Matlab data (cleandata_students.mat)
%   x: Nx45 array, where N = #examples, 45 represents facial action units
%   y: Nx1 vector, representing labels of corresponding examples

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
   
    % Going to test best_attribute; remove it from the attributes_vector
    attributes_vector(attributes_vector == best_attribute) = [];
    
    for value_attribute = 0:1
        % Extracts the rows in the example matrix as examples_i which has
        %   value of best_attribute as value_attribute (0 or 1)
        indices = (examples_matrix(:, best_attribute) == value_attribute);
        examples_i = examples_matrix(indices, :);
        
        % Contains the classification (yes or no) of emotion in 
        %   row of examples.
        binary_targets_i = binary_targets(indices);
        
        % If there is no example that has a particular value_attribute
        %   i.e. all examples have a particular value for the attribute.
        %if (size(examples_i, 1) == 0)
        if isempty(examples_i)
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





