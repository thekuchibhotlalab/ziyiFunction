function [idxAll, idxEach, idxLabel]= fn_multistrcmp(allStr, targetStr)
% fn_multistrcmp(allStr, targetStr)
% Return logical array of whether each element of allStr is inside targetStr

idxAll = zeros(size(allStr));
idxLabel = zeros(size(allStr));
idxEach = cell(1,length(targetStr));

for i = 1:length(targetStr)
   tempIdx = strcmp(allStr,targetStr{i});
   idxAll(tempIdx) = 1;
   idxLabel(tempIdx) = i;
   idxEach{i} = logical(tempIdx);
end
idxAll = logical(idxAll);
end