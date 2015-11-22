function [ matrix ] = confusion_matrix(size, predicted, actual)
%CONFUSION_MATRIX Generates general confusion matrix
%   User inputs size of expected matrix, get length of vector input
%   For length of vector input, increment value of matrix with coordinates
%   corresponding to value in vector row.
    len = length(predicted);
    matrix = zeros(size);
    for n = 1:len
        x = actual(n, :);
        y = predicted(n, :);
        matrix(x, y) = matrix(x, y) + 1;
    end
end