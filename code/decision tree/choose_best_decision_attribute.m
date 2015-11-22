% This function returns the attribute with the highest information gain
%   in the attributes vector.

function [best_attribute] = choose_best_decision_attribute(examples, ... 
                                attributes, binary_targets)
    
    % Create a zero-ed row vector with same dimensions as attributes.
    gain = zeros(size(attributes, 1), 1);
    
    % Calculate information gain for each attribute and store in gain.
    % Delegates calculation of information gain to another function.
    for attr = 1 : length(attributes)
        gain(attr) = information_gain(examples, attributes(attr), ...
                         binary_targets);
    end
    
    % best_idx returns the column number which has the highest info gain.
    % ~ returns the value of the information gain, but we are not concerned
    %   about the value for this function; we just want the highest
    %   information gain.
    [~, best_idx] = max(gain);
    
    % Returns the attribute (number) that has the highest info gain.
    best_attribute = attributes(best_idx);
end

