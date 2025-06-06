function fn_boxplot(data,varargin)

p = inputParser;
p.KeepUnmatched = true;
p.addParameter('dotLoc', [])
p.addParameter('paired', false)
p.addParameter('boxplotArgIn', {})
p.parse(varargin{:});

if ~iscell(data); dataCell = {}; for i = 1:size(data,1); dataCell{i} = data(i,:); end 
else; dataCell = data; end
dataMat = fn_cell2matFillNan(dataCell);

additionalPlotArg = {}; if ~p.Results.paired; additionalPlotArg = {'linestyle','none'}; end

hold on;
% plot the paired lines with dots
for i = 1:size(dataMat,1)
    xLoc = 1:size(dataMat,2);
    if strcmp(p.Results.dotLoc,'random')
        xLoc = xLoc + rand(1,size(dataMat,1))*0.1-0.05; 
    elseif strcmp(p.Results.dotLoc,'side')
        xLoc(1) = xLoc(1) + 0.2; 
        xLoc(2) = xLoc(2) - 0.2; 
    end
    if ~strcmp(p.Results.dotLoc,'none')
        plot(xLoc,dataMat(i,:),'.-','Color',[0.8 0.8 0.8],'Marker','.','MarkerSize',8,...
            'MarkerFaceColor',[0.8 0.8 0.8],'LineWidth',0.5,additionalPlotArg{:});  
    else
        plot(xLoc,dataMat(i,:),'Color',[0.8 0.8 0.8],'LineWidth',0.5,additionalPlotArg{:}); 
    end
end
boxplot(dataMat,p.Results.boxplotArgIn{:},'Whisker',3);