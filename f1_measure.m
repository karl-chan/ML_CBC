function [results] = f1_measure(matrix)
    precision = avg_precision_rate(matrix);
    recall = avg_recall_rate(matrix);
    
    dim = size(matrix, 1);
    results = zeros(1, dim);
    for i = 1 : dim
        results(i) = 2 * precision(i) * recall(i) / (precision(i) + recall(i));
    end        
end