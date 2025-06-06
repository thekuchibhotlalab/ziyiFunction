function correspondingIdx = fn_getUniqueTableEntry(T, fldName)

values = T.(fldName);               % extract the SessionDate column
uniqueVal = unique(values);                   % find unique session dates
correspondingIdx = cell(size(uniqueVal));          % preallocate output cell

for i = 1:length(uniqueVal)
    correspondingIdx{i} = find(values == uniqueVal(i));  % find matching indices
end


end 