function mat = fn_normalizeBySum(mat,dim)
if nargin == 1; dim = 1; end
    
if dim == 1; mat = mat./repmat(sum(mat,1),size(mat,1),1);
elseif dim == 2; mat = mat./repmat(sum(mat,2),1,size(mat,2));
end
    
end