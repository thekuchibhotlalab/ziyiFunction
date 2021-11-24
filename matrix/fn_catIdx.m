function allIdx = fn_catIdx(mat)
% INPUT -- 
% mat: nX2 matrix; each row with start/end idx
if size(mat,1) == 2
    readDim = 2; 
elseif size(mat,2)==2
    readDim = 1; 
else; msgbox('ERROR -- INPUT MATRIX NEEDS TO BE NX2 OR 2XN'); 
end

allIdx = [];
for i = 1:size(mat,readDim)
    if readDim == 1; tempIdx = mat(i,:);
        else; tempIdx = mat(:,i);
    end
    allIdx = cat(2,allIdx,tempIdx(1):tempIdx(2));
end

end