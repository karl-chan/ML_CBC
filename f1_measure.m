function [result] = f1_measure(matrix)
    precision = avg_precision_rate(matrix);
    recall = avg_recall_rate(matrix);
    result = 2 * precision * recall / (precision + recall);
end