function movingPercentile = fn_movPrctile(data,percentileValue,windowSize)
% Define window size and percentile
%windowSize = 10;
%percentileValue = 50; % This is the median (50th percentile)

% Initialize moving percentile array
movingPercentile = NaN(size(data));

% Calculate moving percentile using a sliding window
for i = 1:length(data) - windowSize + 1
    windowData = data(i:i + windowSize - 1);  % Extract window
    movingPercentile(i + floor(windowSize / 2)) = prctile(windowData, percentileValue);  % Calculate percentile
end
movingPercentile(1:floor(windowSize/2)) = movingPercentile(1+floor(windowSize/2));
movingPercentile(end-floor(windowSize/2)+1:end) = movingPercentile(end-floor(windowSize/2));

end