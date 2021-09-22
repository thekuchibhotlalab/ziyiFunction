function dirName = fn_readDir(targetPath)

filenames = dir(targetPath);
dirFlag = cell2mat({filenames.isdir}); dirName = {filenames.name};
dirName = dirName(dirFlag); dirName(1:2) = [];

end