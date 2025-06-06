function [lm,sc] = fn_plotScatterCorr(dataX,dataY,varargin)

% p = inputParser;
% p.KeepUnmatched = true;
% p.addParameter('dotType', 'random')
% p.addParameter('lineType', 'line')
% p.addParameter('barType', 'none')
% p.addParameter('errorbarType', 'errorBar')
% p.addParameter('paired', false)
% p.addParameter('test', 'ttest')
% p.addParameter('barplotArgIn', {0.4,'EdgeColor',[0.2 0.2 0.2],'FaceColor','None','LineWidth',0.5})
% p.addParameter('errorbarArgIn', {'Color',[0.2 0.2 0.2],'LineWidth',1.5})
% p.addParameter('scatterArgIn', {15, [0.6 0.6 0.6],'filled'})
% p.addParameter('plotArgIn', {'Color',[0.6 0.6 0.6],'LineWidth',0.5})
% p.parse(varargin{:});

p = inputParser;
p.KeepUnmatched = true;
p.addParameter('evalCorr', true)
p.addParameter('scatterArgIn', {'filled'})
p.addParameter('scatterColors', {})
p.addParameter('scatterSize', 10)
p.addParameter('lineColor', {})
p.addParameter('corrPlotArgIn', {'LineWidth',0.5})
p.addParameter('xlim', [])
p.addParameter('ylim', [])
p.addParameter('title', {})
p.parse(varargin{:});


if ~iscell(dataX); dataCellX = {};for i = 1:size(dataX,1); dataCellX{i} = dataX(i,:); end 
else;dataCellX = dataX;end
if ~iscell(dataY); dataCellY = {};for i = 1:size(dataY,1); dataCellY{i} = dataY(i,:); end 
else;dataCellY = dataY;end

if isempty(p.Results.scatterColors) % initiate default colors
    for i = 1:length(dataCellY); scatterColors{i} = matlabColors(i,0.6); end 
else 
    scatterColors = p.Results.scatterColors;
end

if isempty(p.Results.lineColor) % initiate default colors
    for i = 1:length(dataCellY); lineColor{i} = matlabColors(i,0.6); end 
else 
    lineColor = p.Results.lineColor;
end

hold on; lm = {}; sc = {};
for i = 1:length(dataCellX)
    sc{i} = scatter(dataCellX{i},dataCellY{i},p.Results.scatterSize,scatterColors{i},p.Results.scatterArgIn{:});
    lm{i} = fitlm(dataCellX{i},dataCellY{i});
end

if ~isempty(p.Results.xlim); xlim(p.Results.xlim); end; if ~isempty(p.Results.ylim); ylim(p.Results.ylim); end
xlimm = xlim; ylimm = ylim; 
xlimm_new = max(abs(xlimm)); xlimm_new = [-xlimm_new xlimm_new];
ylimm_new = max(abs(ylimm)); ylimm_new = [-ylimm_new ylimm_new];

plotCell = []; legendCell = {};
for i = 1:length(dataCellX)
    f = plot(xlimm_new, xlimm_new*lm{i}.Coefficients.Estimate(2) + lm{i}.Coefficients.Estimate(1),'Color',lineColor{i},p.Results.corrPlotArgIn{:});
    legendCell{i} = ['p=' num2str(lm{i}.Coefficients.pValue(2),'%.2e')];
    plotCell(i) = f;
end
legend(plotCell,legendCell); xlim(xlimm_new);ylim(ylimm_new);

end
