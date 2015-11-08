% Generates the predicted vector for use in confusion_matrix function

function[T predicted] = generate_predicted(x, y)  
    y1 = y == 1;
    y2 = y == 2;
    y3 = y == 3;
    y4 = y == 4;
    y5 = y == 5;
    y6 = y == 6;
    t1 = ten_fold_cross_validation(x, 1:45, y1);
    t2 = ten_fold_cross_validation(x, 1:45, y2);
    t3 = ten_fold_cross_validation(x, 1:45, y3);
    t4 = ten_fold_cross_validation(x, 1:45, y4);
    t5 = ten_fold_cross_validation(x, 1:45, y5);
    t6 = ten_fold_cross_validation(x, 1:45, y6);
    T = [t1 t2 t3 t4 t5 t6];
    
    predicted = testTrees(T, x);
                    
end