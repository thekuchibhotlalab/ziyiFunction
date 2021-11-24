function S = fn_readStructByFieldKey(S,selectField,fieldKeys)

selectFlag = fn_multistrcmp(S.(selectField),fieldKeys);

if isstruct(S)
    allFields = fieldnames(S);
elseif isobject(S)
    allFields = properties(S);
end

for j = 1:length(allFields)
    tempField = allFields{j};
    temp = S.(tempField);
    if iscell(temp);S.(tempField) = temp(selectFlag);end
end

end