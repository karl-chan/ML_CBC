function pruning_example(x,y)
    
% x: noSamples x 45 (as returned by loaddata)
% y: noSamples x 1 (as returned by loaddata)

tree = classregtree(x,y,'method','classification','categorical',1:45,'minparent',1,'prune','off');

% 10 fold cross validation to compute cost
% cost: cost
% s(2): standard error (se) of cost
% nodes: no. of terminal nodes for each subtree
% bestLevel(2): est. best level of pruning, best level is one that produces
% smallest tree that is with one se of minimum-cost subtree
[cost,s,nodes,bestLevel] = test(tree,'cross',x,y);
[cost2,s2,nodes2,bestLevel2] = test(tree,'resubstitution');

% prune tree at best level
prunedTree = prune(tree,'level',bestLevel);
prunedTree2 = prune(tree,'level',bestLevel2);

% mincost and corresponding index
[mincost,minloc] = min(cost);
[mincost2,minloc2] = min(cost2);


plot(nodes,cost,'b-x','MarkerSize',8)
hold on
plot(nodes(bestLevel+1),cost(bestLevel+1),'ks');
% plot(nodes(minloc), mincost, 'b--o');
xlabel('Tree size (number of terminal nodes)')
ylabel('Cost')
grid on

plot(nodes2,cost2,'r-x','MarkerSize',8)
% plot(nodes(minloc2), mincost2, 'r--o');
plot(nodes2(bestLevel2+1),cost2(bestLevel2+1),'ks');

