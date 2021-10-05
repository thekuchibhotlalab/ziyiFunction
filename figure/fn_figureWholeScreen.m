function f = fn_figureWholeScreen(varargin)
% f = fn_figureWholeScreen(varargin)
% Default: 'Units', 'Normalized', 'visible', 'OuterPosition', 
%   [0.025, 0.3, 0.95, 0.4]
p = inputParser;
p.KeepUnmatched = true;
p.addParameter('f', [])
p.addParameter('OuterPosition', [0.05, 0.05, 0.9, 0.9])
p.addParameter('Units', 'Normalized')
p.addParameter('visible', 'on')
p.parse(varargin{:}); 
if isempty (p.Results.f); f = figure('visible', p.Results.visible); else; f = p.Results.f; end
set(f, 'Units', p.Results.Units, 'OuterPosition',  p.Results.OuterPosition);
end