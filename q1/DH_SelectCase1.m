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
L = zeros(1,1999);
loss = [];
root = 1999;
L(root)=1;
P=root;
nsample = 1000;
n=zeros(1,1999);
p1=zeros(1,1999);
    for t = 1:1000
    %     children = [];
    %     disp(class(children));
        disp(t);
    %     children = visitnodes(P,T,children);
        
        v = selectP(P,T);
        leaves = [];
        
        leaves = getLeaves(leaves, v, T, nsample);

        z = leaves(randsample(length(leaves),1));


        l = labels(z);

        [n, p1] = updateEmpirical(n, p1, v, z, l, T);
        [Pbest, Lbest] = chooseBestPruningAndLabeling(n, p1, v, T, nsample);
        P = P(P~=v);
        P = [P,Pbest];
        L(Pbest)= Lbest;
%         for u = 1:length(Pbest)

        L = assignLabels(L, v, v, T, nsample);
%         end
        loss = [loss, computeLoss(L(1:1000), labels)];
    %     for v = 1:length(P)
    %         L = assignLabels(L, P(v), P(v), T, nsample);
    %     end
    end
end
function v = selectP(P,T)
    newP = P;
%     rateP = [];
%     for i = 1:length(newP)
%         rateP(i)=T{2}(P(i));
%         
%     end
    rateP = T{2}(P);
    
    [~,k] = max(mnrnd(1,rateP, 1));
    v = P(k);
    
end