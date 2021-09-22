function [outCell, emptyFlag] = fn_removeEmptyEntryCell(inCell)
%FN_REMOVEEMPTYENTRYCELL Summary of this function goes here
%   Detailed explanation goes here
emptyFlag = cellfun(@(x)(~isempty(x)),inCell,'UniformOutput',false);
emptyFlag = fn_cell2mat(emptyFlag,1);
outCell = inCell(logical(emptyFlag));


end

