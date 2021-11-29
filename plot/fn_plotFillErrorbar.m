function f = fn_plotFillErrorbar(xdata,yMean, ySEM,color,varargin)
% f = fn_plotFillErrorbar(xdata,yMean, ySEM,color,varargin)
    if size(xdata,2) == 1; xdata = xdata'; end
    if size(yMean,2) == 1; yMean = yMean'; end
    if size(ySEM,2) == 1; ySEM = ySEM'; end
    x = [xdata, fliplr(xdata)];
    y = [yMean+ySEM, fliplr(yMean-ySEM)];
    isnanFlag = isnan(y); x(isnanFlag) = []; y(isnanFlag) = [];
    f = fill(x,y,color,varargin{:});
end