function [f_mean, f_sample] = fn_plotMeanSampleLine(xdata,ydata, meanArg, lineArg)
% [f_mean, f_sample]= fn_plotMeanErrorBar(xdata,ydata, yMean,fillColor ySEM,plotArg, plotFill)
% xdata: size(1,x)
% ydata: size(samples,y)
% plotArg: e.g. {'Color',[0.8 0.8 0.8] }
% plotFill: e.g. {'Color',[0.8 0.8 0.8]}
    hold on;
    
    for i = 1:size(ydata,1)
        f_sample{i} = plot(xdata,ydata(i,:),lineArg{:});
    end
    yMean = nanmean(ydata,1); 
    f_mean = plot(xdata,yMean,meanArg{:}); 
end
    