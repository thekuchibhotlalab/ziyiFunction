function anyFlag = fn_findAny(array1, array2)
    if size(array1,1) == 1; array1 = array1'; end
    if size(array2,2) == 1; array2 = array2'; end

    anyFlag = sum(array2 == array1,2) > 0;
end