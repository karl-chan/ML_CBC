function [result] = avg_precision_rate(matrix)
    total = 0;
    for n = 1:size(matrix, 1)
        col = matrix(:, n);
        tp = col(n);
        denom = sum(col);
        total = total + tp/denom;
    end
    result = total/size(matrix, 1);
end