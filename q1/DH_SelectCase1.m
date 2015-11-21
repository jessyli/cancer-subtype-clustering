function [L,loss] = DH_SelectCase1(data, labels, T)
%% Main function for DH algorithm
% Input:
%       data: a 1000 by 25 matrix; each row represents the sample from the
%       ith patient. each column is a protein concentration level
%       labels: an 1000 by 1 matrix; each element (i, 1) represents the
%       true subtype of ith sample.
%       T: a cell of length 3
%           T{1}: the linkage of hierachical clustering tree on data,
%           for more details, please refer to http://www.mathworks.com/help/stats/linkage.html#zmw57dd0e352239
%           T{2}: a vector denoting the size of subtree rooted at each
%           node (the number of children plus 1 for itself)
%           T{3}: a vector denoting the parent for each node, the root
%           node's parent is set to 0
% Output:
%       L: a 1 by 1000 vector; ith element represents the predicted
%       label for ith sample.
%       loss: a 1 by 1000 vector; ith element represents the loss after
%       ith round querying
L = [];
P = [];
for i = 1:length(T{3})
    if T{3}(i)==0
        root = i;
    end
end
L(root)=1;
P(0)=root;
nsample = 1000;

for t = 1:1000
    v = randsample(P,1);
    leaves = [];
    n=0;
    p1=0;
    leaves = getLeaves(leaves, v, T, nsample);
    z = randsample(leaves,1);
    l = labels(z);
    [n, p1] = updateEmpirical(n, p1, v, z, l, T);
    [Pbest, Lbest] = chooseBestPruningAndLabeling(n, p1, v, T, nsample);
    P = P(P~=v);
    P = union(P,Pbest);
    for u = 1:length(Pbest)
        L(Pbest(u))= Lbest(Pbest(u));
    end
end
loss = computeLoss(L, labels);
for v = 1:length(P)
    L = assignLabels(L, u, v, T, nsample);
end
end