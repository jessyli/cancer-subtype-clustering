function leaves = getLeaves(leaves, v, T, nsample)
%% Get all leaf nodes in the subtree Tv rooted at v
% Input:
%       leaves: previously found leaves
%       v: current root node
%       T: tree (cell object of length 3, see DH_SelectCase1.m for details)
%       nsamples: number of samples, 1000
% Output:
%       leaves: leavs in the subtree Tv rooted at v
% Hint: you should implement this function recursively
leaves = [];

if T{2}(v) == 1
        leaves = [v];
else
%         parents = T{3};
        children = find(T{3} == v);
        for i = 1:length(children)
            leaves = [leaves, getLeaves(leaves, children(i), T, nsample)];
%             L = assignLabels(L, children(i), v, T, nsample);
        end
%         for m = 1 : length(parent)
%             if parent(m) == v
%                 leaves = [leaves, getLeaves(leaves, m, T, nsample)];
%             end
%         end
    
end
%  if v <= nsample
%       leaves = [v];
%       return
%   end
%   tv = T{1,1};
%   children = tv(v-nsample,1:2);
%   if children(1)<= nsample
%       leaves = [leaves, children(1)];
%   else
%       leaves = getLeaves(leaves, children(1), T, nsample);
%   end
%   
%   if children(2) <= nsample
%       leaves = [leaves, children(2)];
%   else
%       leaves = getLeaves(leaves, children(2), T, nsample);
%   end
% % disp(class(leaves))
% templeaves = visitnodes(v,T, nsample);
% 
%  for i = 1: length(templeaves)
%      if inpre(i, leaves)==0
%         leaves = [leaves, templeaves(i)];
%     end
%  end        
   


end
% find all leaves in tree T
% function leaves = visitnodes(v,T, nsamples)
% leaves = [];
% children = [];
% for i=1:length(T{3})
%     temp = (T{3}(i));
%     
%     if temp==str2double(v)
%         children=[children, i];
%     end
% end
% for i = 1:children
%     if checkleaves(children(i), nsamples)==1;
%         leaves = [leaves, children(i)];
%     else
%         leaves = [leaves, visitnodes(children(i),T)];
%     end
% end
% end
% % check whether the node is leave
% function isleave = checkleaves(v,nsamples)
%     if v<=nsamples
%         isleave = 1;
%     else
%         isleave=0;
%     end
% end
% % check whether the node is previously found
% function isfound = inpre(v, leaves)
%     for i = 1:length(leaves)
%         if v==leaves(i)
%             isfound = 1;
%         else 
%             isfound = 0;
%         end
%     end
% end