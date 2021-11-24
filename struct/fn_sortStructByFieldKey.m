function S = fn_sortStructByFieldKey(S,sortFieldName)

[~, sortIdx] = sort(S.(sortFieldName));

if isstruct(S)
    allFields = fieldnames(S);
elseif isobject(S)
    allFields = properties(S);
end

for j = 1:length(allFields)
    tempField = allFields{j};
    temp = S.(tempField);
    if iscell(temp); S.(tempField) = temp(sortIdx);end
end


end