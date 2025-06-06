function [shift, index_a, index_b, aligned_a, aligned_b] = fn_findBestShift(a, b, errorTolerance)
% FINDBESTSHIFT Find the shift that best aligns two arrays with an error tolerance
%
%   [SHIFT, ALIGNED_A, ALIGNED_B, INDEX_A, INDEX_B] = FINDBESTSHIFT(A, B, ERRORTOLERANCE)
%   finds the best shift value that aligns array B within array A, such that
%   the difference between corresponding elements in A and B is below the
%   specified error tolerance. The function returns the optimal shift and
%   the aligned subarrays, along with the indices of the aligned elements in
%   arrays A and B.
%
%   Inputs:
%   A - The longer array (numeric array)
%   B - The shorter array that you want to align with A (numeric array)
%   ERRORTOLERANCE - Maximum allowable difference between corresponding
%                    elements of A and B to consider them as matching
%                    (positive scalar).
%
%   Outputs:
%   SHIFT - The optimal shift (non-negative integer) that aligns B within A.
%   ALIGNED_A - The subarray of A that best matches B.
%   ALIGNED_B - The array B (aligned with the subarray of A).
%   INDEX_A - The indices of the aligned subarray in A.
%   INDEX_B - The indices of the aligned subarray in B.
%
%   Example:
%       A = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
%       B = [4.1, 5.0, 6.2];
%       errorTolerance = 0.3;
%       [shift, aligned_a, aligned_b, index_a, index_b] = findBestShift(A, B, errorTolerance);
%       disp(shift);           % Expected output: 3
%       disp(aligned_a);       % Expected output: [4, 5, 6]
%       disp(aligned_b);       % Expected output: [4.1, 5.0, 6.2]
%       disp(index_a);         % Expected output: [4, 5, 6]
%       disp(index_b);         % Expected output: [1, 2, 3]
%
%   Notes:
%   - The function assumes that array A is slightly longer than array B.
%   - The function considers only non-negative shifts (i.e., B is shifted
%     within A starting from index 1).
%
%   Author: Your Name
%   Date: October 2024
%

    % Initialize the best shift, max matches, and index outputs
    bestShift = 0;
    maxMatches = 0;
    aligned_a = [];
    aligned_b = [];
    index_a = [];
    index_b = (1:length(b))';  % Indices of b are always 1:length(b)

    % Get the lengths of the two arrays
    len_a = length(a);
    len_b = length(b);
    
    % Iterate over possible shifts (from 0 to len_a - len_b)
    for shiftValue = 0:(len_a - len_b)
        % Extract the subarray of 'a' that aligns with 'b' for the current shift
        sub_a = a(shiftValue + 1 : shiftValue + len_b);
        
        % Count the number of matches within the error tolerance
        matches = sum(abs(sub_a - b) <= errorTolerance);
        
        % Update the best shift if more matches are found
        if matches > maxMatches
            maxMatches = matches;
            bestShift = shiftValue;
            aligned_a = sub_a;  % Save the aligned subarray of A
            aligned_b = b;      % Save B (aligned with A)
            index_a = (shiftValue + 1 : shiftValue + len_b)';  % Indices of A corresponding to aligned_a
        end
    end
    
    % Return the best shift, aligned arrays, and their indices
    shift = bestShift;
end
