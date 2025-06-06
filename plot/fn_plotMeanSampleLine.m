function [f_mean, f_sample] = fn_plotMeanSampleLine(xdata,ydata, meanArg, lineArg)
    hold on;
    
    for i = 1:size(ydata,1)
        f_sample{i} = plot(xdata,ydata(i,:),lineArg{:});
    end
    yMean = nanmean(ydata,1); 
    f_mean = plot(xdata,yMean,meanArg{:}); 
end
    