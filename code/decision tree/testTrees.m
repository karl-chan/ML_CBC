% Returns a vector of classifications (1-6) for each row
% of test data given 
%       T, a vector containing the 6 trained trees, and 
%       x2 a matrix containing test data (N * 45 matrix).
% with depth of leaf in tree as tie breaker when there is a clash.
%
% If multiple trees classify as yes, tree with lowest depth wins.
% If all trees classify as no, tree with highest depth wins.

% Example
%   testTrees(T, [1 0 0 ... 0, 0 1 0 ... 0, ... ]) = [5, 3, ...]

function [predictions] = testTrees(T, x2)
    % Can we preallocate the size of predictions (which we know is N, 
    %   number of rows in the x2 matrix.
    % Then predictions(row_num, 1) = classification
    predictions = zeros(size(x2, 1), 1);
 
    % Loop through rows in x2 using the predict function on each tree
   	for row_num = 1 : size(x2, 1)
        test_data_row = x2(row_num, :);
        classification = map_to_classification(T, test_data_row);
        predictions(row_num) = classification;        
    end
end

% Helper function
% Maps a test data row to the most probable classification
% among a list of given trees
function [classification] = map_to_classification(allTrees, test_data_row)
    potential_classifications = zeros(2, 6);
    emotions = length(allTrees);
    
    % Find out which trees give positive result, and
    % add those to potential_classifications
    for i = 1:emotions
        [boolean, depth]= predict_with_depth(allTrees(i), test_data_row);
        potential_classifications(1, i) = boolean;
        potential_classifications(2, i) = depth;
      
    end
    
    % If none of the trees returned positive,
    % simply randomly allocate a classification value
    if sum(potential_classifications(1, :)) == 0
        indices = find(potential_classifications(2, :) == max(potential_classifications(2, :)));
        classification = indices(1);
        return
    end
    indices = find(potential_classifications(1, :) == 1);
    classification = loop_through_for_min(indices, potential_classifications(2, :));
end

% Returns the index (out of the specified indices)
% of the smallest element in vector
% Example
% loop_through_for_min([1, 3], [8 23 1 7 14 21]) => 3
function [classification] = loop_through_for_min(indices, vector)
    classification = indices(1);
    min = vector(classification);
    for i = indices
        if vector(i) < min
            min = vector(i);
            classification = i;
        end
    end
end
