function [longestSegmentIndices,sideVal] = fn_findLongestAsymptote(y, margin)
    % FINDLONGESTASYMPTOTE Find the longest continuous set of indices
    % that are within the margin of the maximum value of the array.
    %
    % Inputs:
    %   y - Array of data points
    %   margin - Margin of error for the asymptote
    %
    % Output:
    %   longestSegmentIndices - Indices of the longest continuous segment
    
    if nargin == 1; margin = abs(max(y))*0.001;else; margin= abs(max(y))*margin; end 
    % Find the maximum value of the function
    maxValue = max(y);
    
    % Find indices where the function is within the margin of error from the maximum
    asymptoteIndices = find(abs(y - maxValue) <= margin);

    % If no points meet the criterion, return an empty array
    if isempty(asymptoteIndices)
        longestSegmentIndices = [];  sideVal = [nan nan];
        return;
    end
    
    % Find continuous segments within the asymptoteIndices
    longestStart = 0;
    longestLength = 0;

    currentStart = asymptoteIndices(1);
    currentLength = 1;

    % Loop through the asymptoteIndices to find the longest continuous segment
    for i = 2:length(asymptoteIndices)
        if asymptoteIndices(i) == asymptoteIndices(i-1) + 1
            % If current index is continuous with the previous one, increase the length
            currentLength = currentLength + 1;
        else
            % If continuity breaks, check if the current segment is the longest
            if currentLength > longestLength
                longestLength = currentLength;
                longestStart = currentStart;
            end
            % Reset for the next segment
            currentStart = asymptoteIndices(i);
            currentLength = 1;
        end
    end

    % Check the last segment if it's the longest
    if currentLength > longestLength
        longestLength = currentLength;
        longestStart = currentStart;
    end

    % Get the indices of the longest continuous segment
    longestSegmentIndices = longestStart:(longestStart + longestLength - 1);
   
    try sideVal(1) = y(longestSegmentIndices(1)-1);catch; sideVal(1) = 0; end
    try sideVal(2) = y(longestSegmentIndices(2)+1);catch; sideVal(2) = 0; end
    

end