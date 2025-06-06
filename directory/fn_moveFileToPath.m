function fn_moveFileToPath(filename, targetFolderPath)
    % Function to move a file to a specified folder based on a part of the filename
    % Inputs:
    %   filename - Name of the file to move (with extension)
    %   targetFolderPath - Path to the folder containing target folders

    % Get the full path of the file
    [currentFolderPath, name, ext] = fileparts(filename);
    currentFilePath = fullfile(currentFolderPath, [name, ext]);

    % Split the filename by '_'
    nameParts = split(name, '_');
    
    % Check if the filename has enough parts after splitting
    if length(nameParts) < 2
        error('Filename does not contain enough parts after splitting by "_".');
    end
    
    % Get the second string after splitting
    targetFolderName = nameParts{2};

    % Form the path to the target folder under the targetFolderPath
    destinationFolderPath = fullfile(targetFolderPath, targetFolderName);

    % Check if the target folder exists
    if ~isfolder(destinationFolderPath)
        mkdir(destinationFolderPath);
        %error('Target folder "%s" does not exist under the specified path.', targetFolderName);
    end

    % Move the file to the target folder without changing the filename
    destinationFilePath = fullfile(destinationFolderPath, [name, ext]);
    movefile(currentFilePath, destinationFilePath);

    fprintf('File "%s" moved to folder "%s".\n', filename, destinationFolderPath);
end
