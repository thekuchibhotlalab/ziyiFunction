function newS = fn_structfun(func,S,varargin)
    p = inputParser;
    p.KeepUnmatched = true;
    p.addParameter('opsArgIn', {})
    if isstruct(S)
        p.addParameter('fieldCell', fields(S))
    elseif iscell(S)
        p.addParameter('fieldCell', fields(S{1}))
    end 
    p.addParameter('verbose', true)
    p.addParameter('funcName', 'FUNCTION')
    p.parse(varargin{:});
    
    verboseField = '';
    newS = struct();
    for i = 1:length(p.Results.fieldCell)
        if ~isempty(p.Results.opsArgIn)
            if length(p.Results.opsArgIn) == 1
                tempInArg = p.Results.opsArgIn;
            else
                tempInArg = p.Results.opsArgIn{i};
            end
        else; tempInArg = {};
        end
        if isstruct(S)
            try newS.(p.Results.fieldCell{i}) = func(S.(p.Results.fieldCell{i}),tempInArg{:});
            catch; verboseField = [verboseField ' ' p.Results.fieldCell{i}]; end
        elseif iscell(S)
            try 
                temp = cellfun(@(x)(x.(p.Results.fieldCell{i})),S,'UniformOutput',false);
                newS.(p.Results.fieldCell{i}) = func(temp{:},tempInArg{:});
            catch; verboseField = [verboseField ' ' p.Results.fieldCell{i}]; end

        else 
            error('Check input S type, should be either struct or cell')
        end 
    end
    
    if p.Results.verbose && ~isempty(verboseField); disp([p.Results.funcName ' were not applied to these fields --']); disp(verboseField);end
end


