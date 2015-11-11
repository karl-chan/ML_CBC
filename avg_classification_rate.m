function [ rate ] = avg_classification_rate( matrix )
%AVG_CLASSFICATION_RATE Calculates average classification rate
%   CR is no. of correctly classified examples (trace) divided by
%   total no. of examples (sum of matrix)
    total = sum(sum(matrix));
    correct = trace(matrix);
    rate = correct / total;
end

