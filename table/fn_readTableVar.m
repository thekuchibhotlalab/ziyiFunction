function tbl = fn_readTableVar(tbl,varCell)
    
varNames = tbl.Properties.VariableNames;
selFlag = sum(fn_cell2mat(cellfun(@(x)(strcmp(varNames,x)'),varCell,'UniformOutput',false),2),2)>0;
tbl = tbl(:,selFlag);
end