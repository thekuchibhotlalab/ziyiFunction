function mat = fn_attachNan(mat,value,dim)

if dim == 1
    if size(mat,1) < value; mat(end+1:value,:) = nan; end
elseif dim ==2
    if size(mat,2) < value; mat(:,end+1:value) = nan; end
end

end