function fn_textOnImg(plotHandle, textStr, myFontSize)
if ~exist('myFontSize'); myFontSize = 12; end 
% Get the axis limits
ax1 = plotHandle;  % Access the axis handle for the first subplot
xLimits = get(ax1, 'XLim'); 
yLimits = get(ax1, 'YLim'); 

% Define the position for the text (top-right corner)
xPos = xLimits(2);  % Maximum x-value (right edge)
yPos = yLimits(1);  % Minimum y-value (top edge)

% Add the text
text(xPos, yPos, textStr , 'HorizontalAlignment', 'right', 'VerticalAlignment', 'top', 'FontSize', myFontSize, 'Color', 'black');



end 