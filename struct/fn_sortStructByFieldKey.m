function S = fn_sortStructByFieldKey(S,sortFieldName)


[~, sortIdx] = sort(S.(sortFieldName));

allFields = fieldnames(S);

for j = 1:length(allFields)
    tempField = allFields{j};
    temp = S.(tempField);
    S.(tempField) = temp(sortIdx);
end


end