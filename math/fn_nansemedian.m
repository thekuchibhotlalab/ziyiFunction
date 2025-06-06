function s = fn_nansemedian(mat,dim)

if any(size(mat)==1)
    if size(mat,1) == 1
        dim = 2;
    elseif size(mat,1) == 2
        dim = 1;
    end 
else
    
    if nargin == 1
        dim = 1;
    end 

end

n = size(mat,dim);
if dim == 1
    m = repmat(nanmedian(mat),n,1);
elseif dim ==2
    m = repmat(nanmedian(mat),1,n);
end
s = sqrt( nansum((mat-m).^2,dim) / (n*(n-1)) );

end

