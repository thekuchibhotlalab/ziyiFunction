function sem = fn_sem(mat,dim)

sem = std(mat,0,dim)/sqrt(size(mat,dim));


end