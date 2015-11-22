% Predicts classification of a test example (1 * 45 matrix)
% by recursing down a decision tree,
% AND THE DEPTH OF THE TREE AT WHICH THE RESULT IS RETURNED

% Example
%       predict(T1, [1 1 0 1 ... 0]) = [TRUE 8]

function [boolean depth] = predict_with_depth(tree, test_example)
   [boolean depth] = predict(tree, test_example, 0);
end

function [boolean depth] = predict(tree, test_example, current_depth)
    if is_leaf(tree)
        boolean = tree.class;
        depth = current_depth;
        return;
    end
    
    traverse_left = test_example(tree.op) == 0;
    if traverse_left
        [boolean depth] = predict(tree.kids{1}, test_example, current_depth + 1);
    else
        [boolean depth] = predict(tree.kids{2}, test_example, current_depth + 1);        
    end    

end
function [boolean] = is_leaf(tree)
    boolean = isempty(tree.op);
end

