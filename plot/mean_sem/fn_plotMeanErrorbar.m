function [f_line, f_errobar] = fn_plotMeanErrorbar(xdata,ydata,plotColor,fillColor, plotArg,plotFill,medianFlag)
% [f_line, f_errobar]= fn_plotMeanErrorBar(xdata,ydata,fillColor,plotArg, plotFill)
% xdata: size(1,x)
% ydata: size(samples,y)
% plotArg: e.g. {'Color',[0.8 0.8 0.8], }
% plotFill: e.g. {'faceAlpha',0.1,'LineStyle','none'}
    if ~exist("medianFlag")
        medianFlag = false; 
    end
    hold on;
    if ~medianFlag
        yMean = nanmean(ydata,1); 
        nData = sum(~isnan(ydata),1);
        ySEM = fn_nansem(ydata,1);
    else
        yMean = nanmedian(ydata,1); 
        nData = sum(~isnan(ydata),1);
        ySEM = fn_nansemedian(ydata,1);
    end

    
    f_errobar = fn_plotFillErrorbar(xdata,yMean,ySEM,fillColor,'LineStyle','None',plotFill{:});
    f_line = plot(xdata,yMean,'Color',plotColor,plotArg{:}); 
end
    