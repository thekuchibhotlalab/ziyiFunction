function S = fn_readStructByFlag(S,selectFlag)

allFields = fieldnames(S);
for j = 1:length(allFields)
    tempField = allFields{j};
    temp = S.(tempField);
    S.(tempField) = temp(selectFlag);
end

end