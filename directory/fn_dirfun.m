function outputCells = fn_dirfun(directoryPath, funcHandle,dirExt)
    % Applies a specified function to all folders in a directory, capturing one or more outputs.
    % If the function fails for a folder, it returns an empty cell for that folder.
    % For single-output functions, the output is stored directly in a 1D cell array.
    %
    % Inputs:
    %   directoryPath - Path to the directory containing the folders
    %   funcHandle - Function handle to apply to each folder. The function should
    %                take a folder path as input and return one or more outputs.
    %
    % Output:
    %   outputCells - Cell array containing the output for each folder. If there is a single output,
    %                 each cell contains the direct output. If there are multiple outputs, each cell
    %                 contains a cell array of outputs for that folder.
    %
    % Example usage:
    %   results = applyFunctionToAllFoldersAdaptiveOutput('/path/to/directory', @(folder) myFunction(folder));

    % Get a list of all folders in the directory
    if ~exist("fileExt"); dirExt = ''; end 
    folderList = dir([directoryPath dirExt]);
    folderList = folderList([folderList.isdir]);  % Keep only directories
    folderList = folderList(~ismember({folderList.name}, {'.', '..'}));  % Exclude '.' and '..'

    % Initialize output cell array
    outputCells = cell(length(folderList), 1);
    numOutputs = nargout(funcHandle);  % Determine the number of outputs of the function

    % Loop through each folder and apply the function
    for k = 1:length(folderList)
        folderPath = fullfile(directoryPath, folderList(k).name);  % Full path to the folder
        fprintf('Processing folder: %s\n', folderPath);  % Print current folder (optional)
        
        % Try applying the function to the folder and catch any errors
        try
            if numOutputs == 1
                % If the function has only one output
                outputCells{k} = funcHandle(folderPath);
            else
                % If the function has multiple outputs, capture them in a cell array
                [varargout{1:numOutputs}] = funcHandle(folderPath);
                outputCells{k} = varargout;  % Store outputs as a cell array
            end
        catch
            % If an error occurs, store an empty cell for this folder
            fprintf('Error processing folder: %s. Skipping...\n', folderPath);
            outputCells{k} = {};  % Empty cell to indicate failure
        end
    end
end
