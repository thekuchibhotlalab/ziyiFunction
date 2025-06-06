function fn_textOnPlot(textStr, ax, myFontSize)
if ~exist('myFontSize'); myFontSize = 8; end 
% Get the current axis limits
xLimits = ax.XLim;
yLimits = ax.YLim;

% Calculate the position for the text (1/5 up from the bottom)
xPos = (xLimits(1) + xLimits(2)) / 2;  % Centered horizontally
yPos = yLimits(2) - (yLimits(2) - yLimits(1)) / 4;  % 1/5 from the bottom

% Add the text to the figure
set(ax, 'Color', 'none');

% Remove the x-axis and y-axis lines, ticks, and labels
set(ax, 'XColor', 'none', 'YColor', 'none');
axis off;

text(xPos, yPos, textStr, 'HorizontalAlignment', 'center', 'FontSize', myFontSize, 'FontWeight', 'bold');

end 