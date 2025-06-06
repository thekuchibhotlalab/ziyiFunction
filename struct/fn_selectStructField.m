function newS = fn_selectStructField(S,selectField)

newS = S;
if isstruct(S)
    allFields = fieldnames(S);
elseif isobject(S)
    allFields = properties(S);
end

for j = 1:length(allFields)
    if ~contains(allFields{j},selectField); newS = rmfield(newS,allFields{j}); end
end
try
newS = orderfields(newS,selectField);
catch
    disp('oh no')
end
end