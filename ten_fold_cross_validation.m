% Performs ten fold cross validation on a single classification (1 - 6)
% tree

function[tree] = ten_fold_cross_validation(examples_matrix, ...
                    attributes_vector, binary_targets)
     tree = [];
     best_percentage = 0;
     index = 1;
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
        percent =  correct_count / size(test_set, 1) * 100;
        if best_percentage < percent
            tree = t;
            best_percentage = percent
        end
    end     
end

function [training_set test_set] = partition(examples_matrix, ith_partition)
    nrows = size(examples_matrix, 1);
    test_set_start_index = floor((ith_partition - 1) / 10 * nrows) + 1;
    test_set_end_index = floor(ith_partition / 10 * nrows);
    test_set = examples_matrix(test_set_start_index:test_set_end_index, :);
    
    training_set = examples_matrix;
    training_set(test_set_start_index:test_set_end_index, :) = [];
end