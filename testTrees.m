% Returns a vector of classifications (1-6) for each row
% of test data given 
%       T, a vector containing the 6 trained trees, and 
%       x2 a matrix containing test data (N * 45 matrix).

% Example
%   testTrees(T, [1 0 0 ... 0, 0 1 0 ... 0, ... ]) = [5, 3, ...]

function [predictions] = testTrees(T, x2)
    % Can we preallocate the size of predictions (which we know is N, 
    %   number of rows in the x2 matrix.
    % Then predictions(row_num, 1) = classification
    predictions = [];
 
    % Loop through rows in x2 using the predict function on each tree
   	for row_num = 1 : size(x2, 1)
        test_data_row = x2(row_num, :);
        classification = map_to_classification(T, test_data_row);
        predictions = [predictions; classification];        
    end
end

% Helper function
% Maps a test data row to the most probable classification
% among a list of given trees
function [classification] = map_to_classification(allTrees, test_data_row)
    potential_classifications = [];
    max_classification = length(allTrees);
    
    % Find out which trees give positive result, and
    % add those to potential_classifications
    for i = 1:max_classification
        ith_result = predict(allTrees(i), test_data_row);
        if ith_result == 1
            potential_classifications = ...
                [potential_classifications i];
        end
    end
    
    % If none of the trees returned positive,
    % simply randomly allocate a classification value
    if isempty(potential_classifications)
        potential_classifications = 1:max_classification;
    end
    random_number = ceil(rand * length(potential_classifications));
    classification = potential_classifications(random_number);
end