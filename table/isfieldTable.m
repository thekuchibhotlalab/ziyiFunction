function flag = isfieldTable(tbl, names)
    flag = ismember(names, tbl.Properties.VariableNames);
    
    
    
end