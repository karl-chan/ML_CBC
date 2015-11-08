function [ rate ] = classification_rate( matrix )
%CLASSFICATION_RATE Calculates classification rate
%   CR is no. of correctly classified examples (trace) divided by
%   total no. of examples (sum of matrix)
    total = sum(sum(matrix));
    correct = trace(matrix);
    rate = correct / total;
end

