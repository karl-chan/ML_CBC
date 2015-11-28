% Performs ten fold cross validation and returns the confusion
% matrix averaged over the 10 folds


function[avg_confusion_matrix, best_net_so_far]= ten_fold_cross_validation_performance_estimation(x, y)
 
     results = [];
     best_net_so_far = [];
     best_f1_so_far = 0;
    
     
     % Train and pick the best tree using 10-fold cross validation.
     [x2, y2] = ANNdata(x, y);
 
     cum_sum_confusion_matrix = zeros(6);         
     for i = 1 : 10 
        [train_validation_idx, test_idx] = partition(i, x2);
        [train_idx, validation_idx] = subpartition(train_validation_idx);
      
        net = create_trainrp(x, y, 2, 23, 100000, train_idx, validation_idx, [], 0.4, 1.11, 0.5);
        predicted = testANN(net, x2(:, test_idx), @NNout2labels);
        curr_cfmat = confusion_matrix(6, predicted, y(test_idx));
        curr_f1 = mean(f1_measure(curr_cfmat));
        if curr_f1 > best_f1_so_far
           best_net_so_far = net;
           best_f1_so_far = curr_f1;
        end
        cum_sum_confusion_matrix = cum_sum_confusion_matrix + curr_cfmat;
     end  
     avg_confusion_matrix = cum_sum_confusion_matrix / 10;
     avg_classification = avg_classification_rate(avg_confusion_matrix)
     avg_precision = avg_precision_rate(avg_confusion_matrix)
     avg_recall = avg_recall_rate(avg_confusion_matrix)
     avg_f1 = f1_measure(avg_confusion_matrix)
end

function [train_idx, validation_idx] = subpartition(train_validation_idx)
    nrows = size(train_validation_idx, 2);
    validation_set_start_index = 1;
    validation_set_end_index = floor(1 / 9 * nrows);
    validation_idx = validation_set_start_index:validation_set_end_index;
    train_idx = setdiff(train_validation_idx, validation_idx);
end
