function [uniEnt, nUni,uniFlag, idx1, idx2] = fn_unique(inmat)
    [uniEnt, idx1, idx2] = unique(inmat);
    nUni = length(uniEnt);
    uniFlag= {};
    for i = 1:nUni; uniFlag{i} = (inmat == uniEnt(i)); end
end