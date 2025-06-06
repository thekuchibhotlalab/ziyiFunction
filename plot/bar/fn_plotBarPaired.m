function [p] = fn_plotBarPaired(data,test)
% OLD AND DEPRECATED VERSION OF fn_plotBar
if ~iscell(data)
    dataCell = {};
    for i = 1:size(data,1); dataCell{i} = data(i,:); end 
else
    dataCell = data;
end

if nargin == 1; test = 'ttest'; end

plotMean = cellfun(@nanmean,dataCell,'UniformOutput',true); %#ok<*NANMEAN> 

if strcmp(test,'ttest');[h,p] = ttest(dataCell{1},dataCell{2});
else ; [p,h] = signrank(dataCell{1},dataCell{2}); end 
bar(plotMean,'EdgeColor',[0 0 0],'FaceColor','None'); hold on;
for i = 1:length(dataCell{1})
    f = plot([1 2],[dataCell{1}(i) dataCell{2}(i)],'Color',[0.6 0.6 0.6],'Marker','.','MarkerSize',8,...
        'MarkerFaceColor',[0.6 0.6 0.6],'LineWidth',0.5);
end
legend(f,['p = ' num2str(p,'%.3f')])
end