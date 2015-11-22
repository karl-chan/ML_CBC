function [result] = avg_recall_rate(matrix)
    dim = size(matrix, 1);
    result = zeros(1, dim);
    for n = 1:size(matrix, 1)
        row = matrix(n, :);
        tp = row(n);
        denom = sum(row);
        result(n) = tp/denom;
    end
end