function outputCells = fn_dirFilefun(directoryPath, funcHandle, fileExt)
    % Applies a specified function to all files in a directory, capturing one or more outputs.
    % If the function fails for a file, it returns an empty cell for that file.
    % For single-output functions, the output is stored directly in a 1D cell array.
    %
    % Inputs:
    %   directoryPath - Path to the directory containing the files
    %   funcHandle - Function handle to apply to each file. The function should
    %                take a file path as input and return one or more outputs.
    %   fileExt - File extension filter (e.g., '*.tif') to specify files to be processed.
    %
    % Output:
    %   outputCells - Cell array containing the output for each file. If there is a single output,
    %                 each cell contains the direct output. If there are multiple outputs, each cell
    %                 contains a cell array of outputs for that file.
    %
    % Example usage:
    %   results = fn_dirfun('/path/to/directory', @(file) myFunction(file), '*.tif');

    % Get a list of all files with the specified extension in the directory
    if nargin < 3 || isempty(fileExt)
        fileExt = '*';  % Default to all files
    end
    fileList = dir(fullfile(directoryPath, fileExt));
    
    fileList = fileList(~[fileList.isdir]);  % Exclude directories, keep only files

    [~,idx] = natsortfiles({fileList.name});  % Sort file names in natural order
    fileList = fileList(idx);
    % Initialize output cell array
    outputCells = cell(length(fileList), 1);
    numOutputs = nargout(funcHandle);  % Determine the number of outputs of the function

    % Loop through each file and apply the function
    for k = 1:length(fileList)
        filePath = fullfile(directoryPath, fileList(k).name);  % Full path to the file
        fprintf('Processing file: %s\n', filePath);  % Print current file (optional)
        
        % Try applying the function to the file and catch any errors
        try
            
            if numOutputs == 1
                % If the function has only one output
                outputCells{k} = funcHandle(filePath);
            else
                % If the function has multiple outputs, capture them in a cell array
                [varargout{1:numOutputs}] = funcHandle(filePath);
                outputCells{k} = varargout;  % Store outputs as a cell array
            end
        catch
            % If an error occurs, store an empty cell for this file
            fprintf('Error processing file: %s. Skipping...\n', filePath);
            outputCells{k} = {};  % Empty cell to indicate failure
        end
    end
end
