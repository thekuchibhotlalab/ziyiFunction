function T = fn_struct2table(S,varargin)

p = inputParser;
p.KeepUnmatched = true;
p.addParameter('fieldKeys', {})
p.parse(varargin{:});
    
if ~isempty(p.Results.fieldKeys); 
    try
        newS = fn_selectStructField(S,p.Results.fieldKeys);
    catch
        disp('oh')
    end
else; newS = S;
end
fieldKeys = fieldnames(newS); C = struct2cell(newS);
T = table(C{:},'VariableNames',fieldKeys);
end