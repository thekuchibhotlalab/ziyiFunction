function [p] = fn_plotComparison(data,varargin)

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
p.addParameter('meanType', 'mean')
p.addParameter('dotType', '')
p.addParameter('lineType', 'line')
p.addParameter('barType', 'none')
p.addParameter('compType', 'errorbar')
p.addParameter('paired', false)
p.addParameter('test', 'auto')
p.addParameter('barplotArgIn', {0.4,'EdgeColor',[0.2 0.2 0.2],'FaceColor','None','LineWidth',0.5})
p.addParameter('errorbarArgIn', {'Color',[0.2 0.2 0.2],'LineWidth',1.5})
p.addParameter('boxplotArgIn', {'Whisker',3})
p.addParameter('scatterArgIn', {15, [0.6 0.6 0.6],'filled'})
p.addParameter('plotArgIn', {'Color',[0.6 0.6 0.6],'LineWidth',0.5})


p.parse(varargin{:});


if ~iscell(data)
    dataCell = {};
    for i = 1:size(data,1); dataCell{i} = data(i,:); end 
else
    dataCell = data;
end
switch p.Results.meanType
    case 'mean'
        plotMean = cellfun(@nanmean,dataCell,'UniformOutput',true); %#ok<*NANMEAN> 
        plotSEM = cellfun(@fn_nansem,dataCell,'UniformOutput',true); %#ok<*NANMEAN>
    case 'median'
        plotMean = cellfun(@nanmedian,dataCell,'UniformOutput',true); %#ok<*NANMEAN> 
        plotSEM = cellfun(@(x)(iqr(x)/sqrt(numel(x))*1.57),dataCell,'UniformOutput',true); %#ok<*NANMEAN>
end 

hold on;

dotLoc = cell(size(dataCell));
for i = 1:length(dataCell)
    dotLoc{i} = ones(size(dataCell{i})) * i;           
end

switch p.Results.barType
    case 'bar'
        bar(1:length(plotMean), plotMean, p.Results.barplotArgIn{:}); 
end

switch p.Results.dotType
    case 'side'
        if length(dataCell) == 2
            dotLoc{1} = dotLoc{1}-0.05; dotLoc{2} = dotLoc{2}+0.05; 
        else
            disp('SIDE is not supported for more than 2 groups')
        end
    case 'random'
        if p.Results.paired
            randLoc = rand(size(dotLoc{i}))*0.1-0.05;
        for i = 1:length(dataCell); dotLoc{i} = dotLoc{i} + randLoc;end
        else 
            for i = 1:length(dataCell); dotLoc{i} = dotLoc{i} + rand(size(dotLoc{i}))*0.1-0.05;end
        end
end

for i = 1:length(dataCell)
    scatter(dotLoc{i} , dataCell{i}, p.Results.scatterArgIn{:});
end

if p.Results.paired
    switch p.Results.lineType
    case 'line'
        for i = 1:length(dataCell{1})
            tempY = []; tempX=[];
            for j = 1:length(dataCell);tempX = [tempX dotLoc{j}(i)]; tempY = [tempY dataCell{j}(i)]; end 
            plot(tempX,tempY,p.Results.plotArgIn{:});
        end
    end 
end

switch p.Results.compType
    case 'errorbar'
        e = errorbar(plotMean,plotSEM,p.Results.errorbarArgIn{:});%e.LineStyle = 'none';
    case 'errorbarWithDot'
        e = errorbar(plotMean,plotSEM,p.Results.errorbarArgIn{:});%e.LineStyle = 'none';
        scatter(1:length(plotMean),plotMean,40,[0.2 0.2 0.2],'filled');
    case 'line'
        e = plot(1:length(plotMean),plotMean,p.Results.errorbarArgIn{:});
    case 'lineWithDot'
        e = plot(1:length(plotMean),plotMean,p.Results.errorbarArgIn{:});
        scatter(1:length(plotMean),plotMean,40,[0.2 0.2 0.2],'filled');
    case 'boxplot'
        e = boxplot(fn_cell2matFillNan(dataCell),p.Results.boxplotArgIn{:});
end

if length(dataCell) == 2
    ks1 = kstest(dataCell{1}); ks2 = kstest(dataCell{2}); 
    if p.Results.paired
        if strcmp(p.Results.test,'auto')        
            if ~ks1 && ~ks2; useTest = 'ttest'; disp('Normal data detected; use ttest')
            else; useTest = 'signrank'; disp('Un-normal data detected; use signrank'); end 
        else 
            useTest = p.Results.test;
        end 
        if strcmp(useTest,'ttest');[h,p] = ttest(dataCell{1},dataCell{2});
        elseif strcmp(useTest,'signrank'); [p,h] = signrank(dataCell{1},dataCell{2}); end 
        if exist('e','var'); legend(e,['p=' num2str(p,'%.3f')]); end
    else 
        if strcmp(p.Results.test,'auto')        
            if ~ks1 && ~ks2; useTest = 'ttest2'; disp('Normal data detected; use ttest2')
            else; useTest = 'ranksum'; disp('Un-normal data detected; use ranksum'); end 
        else 
            useTest = p.Results.test;
        end 
        if strcmp(useTest,'ttest2');[h,p] = ttest2(dataCell{1},dataCell{2});
        elseif strcmp(useTest,'ranksum'); [p,h] = ranksum(dataCell{1},dataCell{2}); end 
        if exist('e','var'); legend(e,['p=' num2str(p,'%.3f')]); end
    end
else 
    p = nan;
end 

xlim([0.6 length(dataCell)+0.4])

end