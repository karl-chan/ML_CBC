% Performs ten fold cross validation and returns the confusion
% matrix averaged over the 10 folds


function[results] = ten_fold_cross_validation(x, y)
 
     results = [];
     
     % Train and pick the best tree using 10-fold cross validation.
     [x2, y2] = ANNdata(x, y);
     for hidden_neurons = 5:20
         cum_sum_confusion_matrix = zeros(6);
         for i = 1 : 10 
            [train_idx validation_idx] = partition(i);
            net = create_network(x, y, 2, hidden_neurons, 100, train_idx, validation_idx, []);     
            predicted = testANN(net, x2(:, validation_idx), @NNout2labels);
            cum_sum_confusion_matrix = cum_sum_confusion_matrix ...
                  + confusion_matrix(6, predicted, y(validation_idx));
         end
         avg_confusion_matrix = cum_sum_confusion_matrix / 10
         results = [results; mean(f1_measure(avg_confusion_matrix))];
     end     
end

