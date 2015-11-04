function [ ret ] = choose_best_decision_attribute( examples, attributes, binary_targets )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    ig = zeros(size(attributes, 1), 1);
    for idx = 1:length(attributes)
        ig(idx) = information_gain(examples, attributes(idx), binary_targets);
    end
    
    [~, best_idx] = max(ig);
    ret = attributes(best_idx);
end

