function sem = fn_nansem(mat,dim)
if any(size(mat)==1)
    nanCount = sum(~isnan(mat));
    sem = nanstd(mat)/sqrt(nanCount);
else
    
    if nargin == 1
        dim = 1;
    end 
    nanCount = sum(~isnan(mat),dim);
    sem = nanstd(mat,0,dim)./sqrt(nanCount);
end

end