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
    try
        if iscell(temp); S.(tempField) = temp(sortIdx);end
    catch
        disp(['Concatenating error for field ' tempField] )
        S = rmfield(S,tempField);
    end 
end


end