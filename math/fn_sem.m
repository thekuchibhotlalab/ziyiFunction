function sem = fn_sem(mat,dim)

if nargin == 1
    sem = std(mat)/sqrt(length(mat));
else
    sem = std(mat,0,dim)/sqrt(size(mat,dim));
end


end