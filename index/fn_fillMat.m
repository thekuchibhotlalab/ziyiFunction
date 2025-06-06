function mat = fn_fillMat(mat,idx,value)
if nargin == 2; value = nan;end
mat(idx) = value;
end