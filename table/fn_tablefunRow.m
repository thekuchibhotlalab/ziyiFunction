function T_out = fn_tablefunRow(funcHandle, T_in, rowNum)
% fn_tablefunRow - Apply a function to each entry in a specific row of a table.
% If a variable cannot be processed (wrong type), it will silently skip it.
%
% Usage:
%   T_out = fn_tablefunRow(funcHandle, T_in, rowNum)
%
% Inputs:
%   funcHandle - function handle to apply (e.g., @sqrt, @(x) x^2)
%   T_in       - input table
%   rowNum     - row number (integer) to modify
%
% Output:
%   T_out      - modified table with updated row
%
% Example:
%   T = table([1;4],[2;5],{'a';'b'},'VariableNames',{'A','B','C'});
%   T_new = fn_tablefunRow(@(x)x^2, T, 2);
%

    % Copy input table
    T_out = T_in;

    % Validate row index
    if rowNum < 1 || rowNum > height(T_in)
        error('rowNum must be between 1 and %d.', height(T_in));
    end

    % Loop through each column
    for col = 1:width(T_in)
        try
            val = T_in{rowNum, col};            % Extract value
            T_out{rowNum, col} = funcHandle(val); % Apply function
        catch
            % Do nothing (skip column silently)
        end
    end
end
