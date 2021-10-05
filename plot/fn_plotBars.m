function [f,h] = func_barPlot (data, varargin)
p = inputParser;
p.KeepUnmatched = true;
p.addParameter('axes', [])
p.addParameter('legend', [])
p.addParameter('title', [])
p.addParameter('xlim', [])
p.addParameter('xticklabes', [])
p.parse(varargin{:});
        
nPlot = length(data);
if isempty(p.Results.axes)
    f = figure; 
    set(f, 'Units', 'Normalized', 'OuterPosition', [0.025, 0.3, 0.95, 0.4]);
    for i = 1:nPlot
        h{i} = subplot_tight(1,nPlot,i);
    end
else 
    h = p.Results.axes;
    f = ancestor(h{1},'figure');
end

for i = 1:nPlot
    set(f,'CurrentAxes',h{i})
    bar(h{i},data{i});

    if ~isempty (p.Results.title); title(p.Results.title{i}); end
    if ~isempty (p.Results.legend); legend(p.Results.legend{i},'Location','Best'); end
    if ~isempty (p.Results.xlim); xlim(p.Results.xlim{i}); end
    if ~isempty (p.Results.xticklabes); xlim(p.Results.xticklabes{i}); end
end
    
end