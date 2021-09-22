function f = fn_plotFillErrorbar(xdata,yMean, ySEM,color,varargin)
% f = fn_plotFillErrorbar(xdata,yMean, ySEM,color,varargin)
    x = [xdata, fliplr(xdata)];
    y = [yMean+ySEM, fliplr(yMean-ySEM)];
    isnanFlag = isnan(y); x(isnanFlag) = []; y(isnanFlag) = [];
    f = fill(x,y,color,varargin{:});
end