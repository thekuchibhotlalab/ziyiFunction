function fn_plotHistLine(X, varargin)
% fn_plotHistLine(X, varargin)
% histCountArgIn: argument to histcounts, e.g. {edges, 'Normalization',
%   'probability'} or {nbins, 'Normalization','pdf'} 
% plotArgIn: argument to plot, e.g. {'-','Color',[0 0 0]}
p = inputParser;
p.KeepUnmatched = true;
p.addParameter('plotArgIn', {})
p.addParameter('histCountArgIn', {})
p.addParameter('axes', [])
p.parse(varargin{:});

if isempty (p.Results.histCountArgIn)
    [N,edges,bin] = histcounts(X, 'Normalization','probability');
elseif any(strcmp(p.Results.histCountArgIn,'Normalization'))
    [N,edges,bin] = histcounts(X, p.Results.histCountArgIn{:});
else
    [N,edges,bin] = histcounts(X, p.Results.histCountArgIn{:},'Normalization','pdf');
end
edges = edges(2:end) - (edges(2)-edges(1))/2;
if isempty (p.Results.axes)
    plot(edges, N, p.Results.plotArgIn{:});
else
    plot(p.Results.axes, edges, N, p.Results.plotArgIn{:});
end

end