function idx = fn_findFirst(idxFlag)
[~,tempIdx] = find(idxFlag);
idx = tempIdx(1);
end