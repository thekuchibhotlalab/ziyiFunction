function [f,h] = fn_plotPieMultiPanel (data, varargin)
% [f,h] = fn_plotPieMultiPanel (data, varargin)
%
% Vargiin: 'legend' (cell of cell), 'title' (cell), 'axes' (cell),
% 'subplotTight' (false), 'wholeScreen' (false)
%
% Long description

p = inputParser;
p.KeepUnmatched = true;
p.addParameter('legend', [])
p.addParameter('title', [])
p.addParameter('axes', [])
p.addParameter('subplotTight', false)
p.addParameter('wholeScreen', false)
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
    if iscell(p.Results.axes); h = p.Results.axes;
    else; h = {p.Results.axes}; end
end

for i = 1:nPlot
    temp = data{i};
    newData = [];
    for j = 1:length(temp)
        newData = [newData sum(temp{j})];
    end
    newData(newData==0) = 0.1;
    pie(h{i}, newData / sum(newData),ones(1,length(newData)));
    if ~isempty(p.Results.legend); legend(p.Results.legend{i},'Location','Best'); end
    if ~isempty(p.Results.title ); title(p.Results.title{i}); end

end

end