function obj = fn_objfun(func,obj,varargin)
    p = inputParser;
    p.KeepUnmatched = true;
    p.addParameter('opsArgIn', {})
    p.addParameter('propCell', properties(obj))
    p.addParameter('verbose', true)
    p.addParameter('funcName', '')
    p.parse(varargin{:});
    
    verboseProp = '';
    
    for i = 1:length(p.Results.propCell)
        if ~isempty(p.Results.opsArgIn); tempInArg = p.Results.opsArgIn{i};
        else; tempInArg = {};
        end
        
        try obj.(p.Results.propCell{i}) = func(obj.(p.Results.propCell{i}),tempInArg{:});
        catch; verboseProp = [verboseProp ' ' p.Results.propCell{i}]; end
    end
    
    if p.Results.verbose; disp(['Function ' p.Results.funcName ' were not applied to these variables --']); disp(verboseProp);end
end


