% Predicts classification of a test example (1 * 45 matrix)
% by recursing down a decision tree

% Example
%       predict(T1, [1 1 0 1 ... 0]) = TRUE

function [boolean] = predict(tree, test_example)
    if is_leaf(tree)
        boolean = tree.class;
        return;
    end
    
    traverse_left = test_example(tree.op) == 0;
    if traverse_left
        boolean = predict(tree.kids{1}, test_example);
    else
        boolean = predict(tree.kids{2}, test_example);        
    end    
end


function [boolean] = is_leaf(tree)
    boolean = isempty(tree.op);
end

