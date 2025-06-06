function mat = fn_squeeze(mat)
    mat = squeeze(mat);
    if length(size(mat)) == 2 && size(mat,1)==1 % if squeeze to length 2 and squeeze to 1*n
        mat = mat'; % transpose to n*1
    end 
end