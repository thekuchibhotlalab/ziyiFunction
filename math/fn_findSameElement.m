function [indexArray1, indexArray2] = fn_findSameElement(array1, array2, errorTolerance)
    % Initialize arrays to hold the matching indices
    indexArray1 = [];
    indexArray2 = [];
    
    % Loop through each element in array1
    for i = 1:length(array1)
        % Find elements in array2 that are within the error tolerance of the current element in array1
        matches = find(abs(array2 - array1(i)) < errorTolerance);
        
        % If any matches are found, store the indices
        if ~isempty(matches)
            indexArray1 = [indexArray1; i * ones(length(matches), 1)];
            indexArray2 = [indexArray2; matches];
        end
    end
end