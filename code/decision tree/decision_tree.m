% Main file for creating decision tree.

function[tree] = decision_tree(examples_matrix, attributes_vector, ...
                                   binary_targets)

    % tree.op: label for node (empty for leaf node)
    % tree.kids: cell array which contains subtrees (empty for leaf node)
    % tree.class: label for leaf node (empty for internal node)

    % If all of classifications are the same
    if all(binary_targets == binary_targets(1))
        tree = [];
        tree.op = [];
        tree.kids = [];
        tree.class = binary_targets(1);
        return;
    % If there is no more attribute to test for/classify
    elseif isempty(attributes_vector)
        tree = [];
        tree.op = [];
        tree.kids = [];
        tree.class = majority_value(binary_targets);
        return;
    % If none of the cases happens, branch out node according to best
    %   attribute using information gain
    else
        best_attribute = choose_best_decision_attribute(examples_matrix,...
                              attributes_vector, binary_targets);
        tree = [];
        tree.op = best_attribute;
        tree.kids = {};
        tree.class = [];

        for value_attribute = 0:1
            % Extracts the rows in the example matrix as examples_i which
            %  has value of best_attribute as value_attribute (0 or 1)
            indices = (examples_matrix(:, best_attribute) ...
                           == value_attribute);
            examples_i = examples_matrix(indices, :);

            % Contains the classification (yes or no) of emotion in 
            %   row of examples (returns either 0 or 1).
            binary_targets_i = binary_targets(indices);

            % If there is no example that has a particular value_attribute
            if isempty(examples_i)
                tree = [];
                tree.op = [];
                tree.kids = [];
                tree.class = majority_value(binary_targets);
                return;
            else
                tree.kids{value_attribute + 1} = decision_tree( ...
                    examples_i, ...
                    setdiff(attributes_vector, best_attribute), ...
                    binary_targets_i);
            end
        end
    end
end




