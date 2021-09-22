function [f_line, f_errobar] = fn_plotMeanErrorbar(xdata,ydata,fillColor, plotArg,plotFill)
% [f_line, f_errobar]= fn_plotMeanErrorBar(xdata,ydata, yMean,fillColor ySEM,plotArg, plotFill)
% xdata: size(1,x)
% ydata: size(samples,y)
% plotArg: e.g. {'Color',[0.8 0.8 0.8], }
% plotFill: e.g. {'faceAlpha',0.1,'LineStyle','none'}
    hold on;
    yMean = nanmean(ydata,1); 
    nData = sum(~isnan(ydata),1);
    ySEM = nanstd(ydata,0,1) ./ sqrt(nData);
    
    f_line = plot(xdata,yMean,plotArg{:}); 
    f_errobar = fn_plotFillErrorbar(xdata,yMean,ySEM,fillColor,plotFill{:});
end
    