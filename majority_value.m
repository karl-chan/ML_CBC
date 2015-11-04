% Returns the mode of the binary_targets (either 0 or 1)

function [majority_value] = majority_value(binary_targets)
    majority_value = mode(binary_targets);

