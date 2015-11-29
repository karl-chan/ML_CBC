% Performs ten fold cross validation and returns the confusion
% matrix averaged over the 10 folds

% method - boolean switch:
%   0 - uses testTrees (depth analysis method)
%   1 - uses testTreesRandom (randomised tie breaker method)
%   2 - uses testTreesWithProbability (probability analysis method)

function[avg_confusion_matrix] = ten_fold_cross_validation(x, y, method)

     % Total number of emotions, which is 6 in our case
     num_emotions = 6;
     
     % Total number of folds, which is ten in our case
     num_folds = 10; 
     
     % Attributes, vector of AU labels
     attributes = 1 : 45;
     
     % Cumulative sum of all the confusion matrices to be evaluated
     cum_sum_confusion_matrix = zeros(num_emotions);
     
     % Train and pick the best tree using 10-fold cross validation.
     for i = 1 : num_folds  
          T = [];
          [training_x training_y test_x test_y] = partition(x, y, i);
          for emotion = 1 : num_emotions
              binary_targets = training_y == emotion;
              tree = decision_tree(training_x, attributes, binary_targets);

              % Number of times the tree classifies the row as true (1)
             counter_yes = 0;

             % Number of times the row in the matrix gives true (1)
             counter_true = 0;

             index = 1;
             whole_binary_target = y == emotion;
             for row = x'
                 if predict(tree, row)
                     counter_true = counter_true + whole_binary_target(index);
                     counter_yes = counter_yes + 1;
                 end
                 index = index + 1;
             end

             tree.prob_yes = counter_true/counter_yes;

             % Number of times the row in the matrix gives false (0)
             counter_false = 0;

             % Number of times the tree classifies the row as false
             counter_no = size(x,1) - counter_yes;
             index = 1;

             for row = x'
                 if predict(tree, row) == 0
                     counter_false = counter_false + whole_binary_target(index);
                 end
                 index = index + 1;
             end
             tree.prob_false = counter_false/counter_no;
             T = [T tree];
          end
          
          if method == 0
              predictions = testTrees(T, test_x); 
          elseif method == 1
              predictions = testTreesRandom(T, test_x);
          else 
              predictions = testTreesWithProbability(T, test_x);
          end
          cum_sum_confusion_matrix = cum_sum_confusion_matrix ...
              + confusion_matrix(num_emotions, predictions, test_y);
     end
     avg_confusion_matrix = cum_sum_confusion_matrix / num_folds;
     
     % Number of times the tree classifies the row as true (1)
     counter_yes = 0;
     
     % Number of times the row in the matrix gives true (1)
     counter_true = 0;
     
end

% Helper function to split example matrix into test and training sets
function [training_x training_y test_x test_y] = partition(examples_matrix, binary_targets, ith_partition)
    nrows = size(examples_matrix, 1);
    test_set_start_index = floor((ith_partition - 1) / 10 * nrows) + 1;
    test_set_end_index = floor(ith_partition / 10 * nrows);
    range = test_set_start_index:test_set_end_index;
    test_x = examples_matrix(range, :);
    test_y = binary_targets(range);
    
    training_x = examples_matrix;
    training_y = binary_targets;
    training_x(range, :) = [];
    training_y(range) = [];
end
