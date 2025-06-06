function [mat, nanFlag] = fn_removeNan(mat,dim)

if nargin == 1 % 1-D array
    nanFlag = isnan(mat);
    mat(nanFlag) = [];
else
    nanFlag = sum(isnan(mat),dim);
    disp('UNFINISHED')
    
end

end