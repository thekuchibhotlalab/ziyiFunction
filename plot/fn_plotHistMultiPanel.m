function [f,h] = fn_plotHistMultiPanel (data, varargin)
% [f,h] = fn_plotHistMultiPanel (data, varargin)
% Data: cell of cell arrays. Cell 1: subplots. Cell 2: plots on each subplot.
%   e.g. {{distribution1, distribution2}}
% Varargin: 'legend', 'title', 'xlim', 'axes', 'subplotTight' (false),
%   'wholeScreen','histCountArgIn'

p = inputParser;
p.KeepUnmatched = true;
p.addParameter('legend', [])
p.addParameter('title', [])
p.addParameter('xlim', [])
p.addParameter('axes', [])
p.addParameter('subplotTight', false)
p.addParameter('wholeScreen', false)
p.addParameter('histCountArgIn', {})
p.addParameter('plotArgIn', {})
p.parse(varargin{:});
        
nPlot = length(data);
if isempty(p.Results.axes)
    if p.Results.wholeScreen;f = fn_figureWholeScreen;
    else; f = figure; end 
    for i = 1:nPlot
        if p.Results.subplotTight; h{i} = subplot_tight(1,nPlot,i);
        else; h{i} = subplot(1,nPlot,i); end
    end
else 
    h = p.Results.axes;
end

for i = 1:nPlot
    temp = data{i};
    for j = 1:length (temp)
        hold on;
        fn_plotHistLine(temp{j}, 'histCountArgIn' ,p.Results.histCountArgIn,...
            'plotArgIn', p.Results.plotArgIn , 'axes', h{i});
    end
    if ~isempty (p.Results.title); title(p.Results.title{i}); end
    if ~isempty (p.Results.legend); legend(p.Results.legend{i},'Location','Best'); end
    if ~isempty (p.Results.xlim); xlim(p.Results.xlim{i}); end
end
    
end