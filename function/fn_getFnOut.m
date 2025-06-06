function outCell = fn_getFnOut(fhandle, argsIn,varargin)
    
p = inputParser; p.KeepUnmatched = true; arg = {'nargs';nargout(fhandle)}; 
    cellfun(@(x,y)(p.addParameter(x,y)),arg(1,:),arg(2,:)); p.parse(varargin{:});
            
outCell = cell(1,p.Results.nargs);
[outCell{:}] = fhandle(argsIn{:});
    
end