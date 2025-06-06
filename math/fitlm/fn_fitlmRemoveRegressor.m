function [rsq,coeffEst,coeffP,lm] = fn_fitlmRemoveRegressor(tbl,removeName)

nVar = size(tbl,2);  % the number of variables 
nReg = nVar - 1;  % the number of regressors
removeIdx = find(strcmp(tbl.Properties.VariableNames,removeName));
tempTbl = tbl; tempTbl(:,removeIdx) = [];

lm = fitlm(tempTbl,'ResponseVar',tempTbl.Properties.VariableNames{end});

rsq = lm.Rsquared.Ordinary; coeffEst = lm.Coefficients.Estimate'; coeffP = lm.Coefficients.pValue';

coeffEst(removeIdx+2:end+1) = coeffEst(removeIdx+1:end); coeffEst(removeIdx+1) = nan;
coeffP(removeIdx+2:end+1) = coeffP(removeIdx+1:end); coeffP(removeIdx+1) = nan;
end