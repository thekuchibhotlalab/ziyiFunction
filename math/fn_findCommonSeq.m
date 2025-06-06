function [index_a, index_b,longest_a, longest_b ] = fn_findCommonSeq(a, b, errorTolerance)
% FINDLONGESTCOMMONSUBSEQUENCE Find the longest consecutive similar sequence in A and B
%
%   [LONGEST_A, LONGEST_B, INDEX_A, INDEX_B] = FINDLONGESTCOMMONSUBSEQUENCE(A, B, ERRORTOLERANCE)
%   finds the longest consecutive sequence that is shared between arrays A and B,
%   within a given error tolerance. The function returns the longest sequence in A
%   and B, as well as their indices in the original arrays.
%
%   Inputs:
%   A - First input array (numeric array)
%   B - Second input array (numeric array)
%   ERRORTOLERANCE - Maximum allowable difference between corresponding elements of A and B.
%
%   Outputs:
%   LONGEST_A - Longest consecutive subarray found in A.
%   LONGEST_B - Longest consecutive subarray found in B.
%   INDEX_A - Indices in A corresponding to LONGEST_A.
%   INDEX_B - Indices in B corresponding to LONGEST_B.
%
%   Example:
%       A = [1, 2, 3, 4, 5, 6, 7, 8];
%       B = [3.1, 4.0, 5.2, 10];
%       errorTolerance = 0.3;
%       [longest_a, longest_b, index_a, index_b] = findLongestCommonSubsequence(A, B, errorTolerance);
%       disp(longest_a);  % Expected output: [3, 4, 5]
%       disp(longest_b);  % Expected output: [3.1, 4.0, 5.2]
%       disp(index_a);    % Expected output: [3, 4, 5]
%       disp(index_b);    % Expected output: [1, 2, 3]
%
%   Author: Your Name
%   Date: October 2024
%

    len_a = length(a);
    len_b = length(b);
    
    % Initialize tracking variables for the longest matching sequence
    maxLength = 0;
    longest_a = [];
    longest_b = [];
    index_a = [];
    index_b = [];
    
    % Create a dynamic programming table to find the longest common subarray
    % Initialize the table to store the length of matching subsequences
    dp = zeros(len_a, len_b);
    
    % Iterate through both arrays and fill the DP table
    for i = 1:len_a
        for j = 1:len_b
            % Check if the elements are within the error tolerance
            if abs(a(i) - b(j)) <= errorTolerance
                if i == 1 || j == 1
                    dp(i, j) = 1;  % First row/column base case
                else
                    dp(i, j) = dp(i - 1, j - 1) + 1;  % Extend the matching sequence
                end
                
                % Check if we have found a longer matching subsequence
                if dp(i, j) > maxLength
                    maxLength = dp(i, j);
                    longest_a = a(i - maxLength + 1 : i);
                    longest_b = b(j - maxLength + 1 : j);
                    index_a = (i - maxLength + 1 : i)';
                    index_b = (j - maxLength + 1 : j)';
                end
            end
        end
    end
    
    % If no matches are found, return empty outputs
    if maxLength == 0
        disp('No common subsequence found within the given error tolerance.');
    end
end
