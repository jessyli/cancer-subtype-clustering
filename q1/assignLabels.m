function L = assignLabels(L, u, v, T, nsample)
%% Assign labels to every leaf according to the label of the subtree's root node
%   Input:
%       L: predicted label of each node
%       u: current node
%       v: subtree's root node
%       T: tree (cell object of length 3, see DH_SelectCase1.m for details)
%       nsample: number of samples, 1000
%   Output:
%       L: predicted label of each node
% Hint: you should implement this function recursively
rootlabel = L(v);
L(u)=rootlabel;
if u>nsample
    children = find(T{3}==u);
    L(children)=rootlabel;
    
    for i = 1:length(children)
        
        L = assignLabels(L, children(i), v, T, nsample);
    end
end
    
    



    


% children = [];
% children = visitnodes(v,T,children);
% for i = 1: length(children)
%     if (L(children(i))~=rootlabel)
%         L(children(i))=rootlabel;
%     end
% end
% leaves = [];
% leaves = getLeaves(leaves, v, T, nsample);
% for i = 1: length(leaves)
%      if (L(leaves(i))~=rootlabel)
%          L(leaves(i))=rootlabel;
%      end
%  end


end
% get all the children of subtree
% function children = visitnodes(v,T,children)
%     for i=1:length(T{3})
%         if T{3}(i)==v
%             children=[children, i];
%         end
%     end
%     for i = 1:children
%         if (T{2}-1)>0
%             visitnodes(children(i),T,children)
%         end
%     end
% end