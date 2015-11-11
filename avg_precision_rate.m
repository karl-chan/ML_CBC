function [result] = avg_precision_rate(matrix)
    dim = size(matrix, 1);
    result = zeros(1, dim);
    for n = 1:size(matrix, 1)
        col = matrix(:, n);
        tp = col(n);
        denom = sum(col);
        result(n) = tp/denom;
    end
end