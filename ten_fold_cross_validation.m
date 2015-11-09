% Performs ten fold cross validation on a single classification (1 - 6)
% tree

function[tree] = ten_fold_cross_validation(examples_matrix, ...
                    attributes_vector, binary_targets)
     tree = [];
     best_percentage = 0;
     
     % Index variable to traverse through binary_targets
     index = 1;
     
     % Train and pick the best tree using 10-fold cross validation.
     for i = 1 : 10
        [training_set test_set] = partition(examples_matrix, i);
        t = decision_tree(training_set, attributes_vector, binary_targets);
        
        correct_count = 0;
        for row = test_set'
           if predict(t, row) == binary_targets(index)
               correct_count = correct_count + 1;
           end
           index = index + 1;
        end
        
        % Picks best tree based on tree that has the highest proportion
        %   of correctly classified examples.
        percent =  correct_count / size(test_set, 1) * 100;
        if best_percentage < percent
            tree = t;
            best_percentage = percent;
        end
     end
     
     % Number of times the tree classifies the row as true (1)
     counter_yes = 0;
     
     % Number of times the row in the matrix gives true (1)
     counter_true = 0;
     
     index = 1;
     for row = examples_matrix'
         if predict(tree, row)
             counter_true = counter_true + binary_targets(index);
             counter_yes = counter_yes + 1;
         end
         index = index + 1;
     end
     
     tree.prob_yes = counter_true/counter_yes;
     
     % Number of times the row in the matrix gives false (0)
     counter_false = 0;
     
     % Number of times the tree classifies the row as false
     counter_no = size(examples_matrix,1) - counter_yes;
     index = 1;
     
     for row = examples_matrix'
         if predict(tree, row) == 0
             counter_false = counter_false + binary_targets(index);
         end
         index = index + 1;
     end
     tree.prob_false = counter_false/counter_no;
end

% Helper function to split example matrix into test and training sets
function [training_set test_set] = partition(examples_matrix, ith_partition)
    nrows = size(examples_matrix, 1);
    test_set_start_index = floor((ith_partition - 1) / 10 * nrows) + 1;
    test_set_end_index = floor(ith_partition / 10 * nrows);
    test_set = examples_matrix(test_set_start_index:test_set_end_index, :);
    
    training_set = examples_matrix;
    training_set(test_set_start_index:test_set_end_index, :) = [];
end