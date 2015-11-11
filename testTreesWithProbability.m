function [predictions] = testTreesWithProbability(T, x2)
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
    prob_yes = 0;
    for i = 1:length(potential_classifications)
        prob_yes = allTrees(potential_classifications(i)).prob_yes + prob_yes;
    end
    ran = rand;
    ran = ran * prob_yes;
    for i = 1:length(potential_classifications)
        ran = ran - allTrees(potential_classifications(i)).prob_yes;
        if ran < 0
            classification = potential_classifications(i);
            return;
        end
    end
    % If none of the trees returned positive,
    % simply randomly allocate a classification value
    if isempty(potential_classifications)
        potential_classifications = 1:max_classification;
    end
    prob_no = 0;
    for i = 1:length(potential_classifications)
        prob_no = allTrees(potential_classifications(i)).prob_false + prob_no;
    end
    ran = rand;
    ran = ran * prob_no;
    for i = 1:length(potential_classifications)
        ran = ran - allTrees(potential_classifications(i)).prob_false;
        if ran < 0
            classification = potential_classifications(i);
            return;
        end
    end
end
