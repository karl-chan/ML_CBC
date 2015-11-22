% Returns indices for training set and test set
% e.g. partition(1) => [1:900 , 901:1004]
function [training_idx testing_idx] = partition(ith_partition)
    nrows = 1004;
    test_set_start_index = floor((ith_partition - 1) / 10 * nrows) + 1;
    test_set_end_index = floor(ith_partition / 10 * nrows);
    testing_idx = test_set_start_index:test_set_end_index;
    training_idx = setdiff(1:nrows, testing_idx);
end