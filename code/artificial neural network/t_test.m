function [] = t_test()
    decision_tree_clean = [0.2500	0.3100	0.1980	0.2900	0.2079	0.2600	0.2400	0.2277	0.2500	0.2475];
    decision_tree_noisy = [0.3100	0.3400	0.4000	0.4100	0.3400	0.3700	0.3500	0.4600	0.3800	0.3069];
    
    traingd_clean = [0.1600	0.1900	0.1782	0.2200	0.1287	0.1700	0.2300	0.1386	0.1800	0.1386];
    traingd_noisy = [0.2600	0.2800	0.3000	0.2300	0.3100	0.2900	0.3000	0.3100	0.2900	0.2277];
    
    traingda_clean = [0.1700    0.1700	0.1188	0.1700	0.1485	0.1700	0.2200	0.1782	0.2100	0.1683];
    traingda_noisy = [0.3300	0.3000	0.3300	0.2800	0.2800	0.2900	0.3800	0.2800	0.3000	0.1782];
    
    traingdm_clean = [0.1400	0.2400	0.1485	0.2500	0.1584	0.2200	0.2300	0.1881	0.1900	0.0990];
    traingdm_noisy = [0.2700	0.2700	0.2400	0.2300	0.3000	0.2800	0.3200	0.2800	0.2200	0.2475];
    
    trainrp_clean = [0.1900	0.2200	0.1386	0.2200	0.1683	0.1800	0.1700	0.1287	0.1600	0.0990];
    trainrp_noisy = [0.3400	0.3400	0.3100	0.2500	0.2300	0.2900	0.3200	0.3000	0.2800	0.1980];
     
    [h1,p1,ci1,stats1] = ttest(decision_tree_clean, traingd_clean)
    [h2,p2,ci2,stats2] = ttest(decision_tree_noisy, traingd_noisy)
    
    [h3,p3,ci3,stats3] = ttest(decision_tree_clean, traingda_clean)
    [h4,p4,ci4,stats4] = ttest(decision_tree_noisy, traingda_noisy)
    
    [h5,p5,ci5,stats5] = ttest(decision_tree_clean, traingdm_clean)
    [h6,p6,ci6,stats6] = ttest(decision_tree_noisy, traingdm_noisy)
    
    [h7,p7,ci7,stats7] = ttest(decision_tree_clean, trainrp_clean)
    [h8,p8,ci8,stats8] = ttest(decision_tree_noisy, trainrp_noisy)

end