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

templeaves = visitnodes(v,T, nsample);
% numpre = length(leaves);
% numfound = nsample-numpre;
for i = 1: length(templeaves)
    if inpre(i, leaves)==0
        leaves = [leaves, templeaves(i)];
    end
end        
    


end
% find all leaves in tree T
function leaves = visitnodes(v,T, nsamples)
leaves = [];
children = [];
for i=1:length(T{3})
    if T{3}(i)==v
        children=[children, i];
    end
end
for i = 1:children
    if checkleaves(children(i), nsamples)==1;
        leaves = [leaves, children(i)];
    else
        leaves = [leaves, visitnodes(children(i),T)];
    end
end
end
% check whether the node is leave
function isleave = checkleaves(v,nsamples)
    if v<=nsamples
        isleave = 1;
    else
        isleave=0;
    end
end
% check whether the node is previously found
function isfound = inpre(v, leaves)
    for i = 1:length(leaves)
        if v==leaves(i)
            isfound = 1;
        else 
            isfound = 0;
        end
    end
end