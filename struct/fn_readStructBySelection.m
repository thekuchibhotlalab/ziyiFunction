function S = fn_readStructBySelection(S,varargin)

p = inputParser;
p.KeepUnmatched = true;
p.addParameter('fieldKeys', {})
p.addParameter('selectField', '')
p.addParameter('selectFlag', [])
p.parse(varargin{:});
    
if ~isempty(p.Results.fieldKeys) && ~isempty(p.Results.selectField)
    selectFlag = fn_multistrcmp(S.(p.Results.selectField),p.Results.fieldKeys);
else
    selectFlag = p.Results.selectFlag;
end

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