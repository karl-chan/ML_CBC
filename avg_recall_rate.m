function [result] = avg_recall_rate(matrix)
    total = 0;
    for n = 1:size(matrix, 1)
        row = matrix(n, :);
        tp = row(n);
        denom = sum(row);
        total = total + tp/denom;
    end
    result = total/size(matrix, 1);
end