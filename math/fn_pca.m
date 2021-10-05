function [basis, varExp, proj, covMat] = fn_pca(mat,varargin)
% [basis, varExp, proj, covMat] = fn_pca(mat,varargin)
% Varargin


p = inputParser;
p.KeepUnmatched = true;
p.addParameter('zscore', true)
p.parse(varargin{:});

mat = mat - repmat(mean(mat,2),1,size(mat,2));
if p.Results.zscore
    mat = zscore(mat,0,2);
end
covMat = cov(mat');
[u,v] = eig(covMat);
v = diag(v);
[varExp,idx] = sort(v,'descend');
basis = u(:,idx);
tempBasisSum = sum(basis,1);

basis(:,tempBasisSum<0) = -basis(:,tempBasisSum<0);


varExp = varExp ./ sum(varExp);
cumVarExp = cumsum(varExp); 
proj = basis' * mat;

end