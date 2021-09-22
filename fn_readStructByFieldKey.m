function S = fn_readStructByFieldKey(S,selectField,fieldKeys)

selectFlag = fn_multistrcmp(S.(selectField),fieldKeys);
allFields = fieldnames(S);
for j = 1:length(allFields)
    tempField = allFields{j};
    temp = S.(tempField);
    S.(tempField) = temp(selectFlag);
end

end