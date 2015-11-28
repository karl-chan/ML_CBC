<<<<<<< HEAD
% Performs ten fold cross validation and returns the F1 measure
% averaged over the ten folds
=======
% Performs ten fold cross validation and returns the confusion
% matrix averaged over the 10 folds
>>>>>>> aa092d7a927e03b828b9873457197c9be1298e8d


function[results] = ten_fold_cross_validation_parameter_estimation(x, y)
 
     results = [];
     
     % Train and pick the best tree using 10-fold cross validation.
     [x2, y2] = ANNdata(x, y);
<<<<<<< HEAD
     for lr = 0.1 : 0.3 : 0.9
         for inc = 1.01: 0.1 : 1.51
             for dec = 0.1 : 0.2 : 0.9
                 cum_sum_confusion_matrix = zeros(6);         
                 for i = 1 : 10 
                    [train_idx validation_idx] = partition(i);
                    net = create_traingda(x, y, 2, 30, 300, train_idx, validation_idx, [], lr, inc, dec);     
=======
     for hidden_neurons_1 = 5:50
             for lr = 0.1:0.05:0.7
                 cum_sum_confusion_matrix = zeros(6);         
                 for i = 1 : 10 
                    [train_idx validation_idx] = partition(i);
                    net = create_traingd(x, y, 2, hidden_neurons_1, 10000, train_idx, validation_idx, [], lr);     
>>>>>>> aa092d7a927e03b828b9873457197c9be1298e8d
                    predicted = testANN(net, x2(:, validation_idx), @NNout2labels);
                    cum_sum_confusion_matrix = cum_sum_confusion_matrix ...
                          + confusion_matrix(6, predicted, y(validation_idx));
                 end  
                 avg_confusion_matrix = cum_sum_confusion_matrix / 10
                 results = [results; mean(f1_measure(avg_confusion_matrix))]
             end
<<<<<<< HEAD
         end
     end
=======
     end
     
>>>>>>> aa092d7a927e03b828b9873457197c9be1298e8d
end

