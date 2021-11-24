function logicalMat = fn_idx2logical(idx,len)

logicalMat = zeros(len,1);
logicalMat(idx) = 1;
logicalMat = logical(logicalMat);


end