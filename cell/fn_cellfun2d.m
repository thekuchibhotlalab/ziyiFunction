function output = fn_cellfun2d(func, cellArray)
% cellfun2d applies a function to each element of a 2D cell array,
% passing the value and its (row, col) index as arguments.
%
% Usage:
%   output = cellfun2d(@(val, i, j) yourFunc(val, i, j), cellArray)
%
% Inputs:
%   func      - function handle of the form @(val, i, j)
%   cellArray - input 2D cell array
%
% Output:
%   output    - cell array of the same size, with output of func

    [m, n] = size(cellArray);
    output = cell(m, n);
    
    for i = 1:m
        for j = 1:n
            output{i,j} = func(cellArray{i,j});
        end
    end
end
