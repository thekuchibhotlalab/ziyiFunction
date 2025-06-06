function obj = fn_objfun(func,obj,varargin)
    p = inputParser;
    p.KeepUnmatched = true;
    p.addParameter('opsArgIn', {})
    p.addParameter('propCell', properties(obj))
    p.addParameter('verbose', true)
    p.addParameter('funcName', 'FUNCTION')
    p.parse(varargin{:});
    
    verboseProp = '';
    
    for i = 1:length(p.Results.propCell)
        if ~isempty(p.Results.opsArgIn)
            if length(p.Results.opsArgIn) == 1
                tempInArg = p.Results.opsArgIn;
            else
                tempInArg = p.Results.opsArgIn{i};
            end
        else; tempInArg = {};
        end
        
        try obj.(p.Results.propCell{i}) = func(obj.(p.Results.propCell{i}),tempInArg{:});
        catch; verboseProp = [verboseProp ' ' p.Results.propCell{i}]; end
    end
    
    if p.Results.verbose && ~isempty(verboseProp); disp([p.Results.funcName ' were not applied to these properties --']); disp(verboseProp);end
end


