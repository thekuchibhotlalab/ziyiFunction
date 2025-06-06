function outmat = fn_binMean(mat, bin,dim)
if size(mat,1) == 1; dim = 2;
elseif size(mat,2) == 1; dim = 1;
elseif nargin == 2 || isempty(dim); dim = 1; 
end

binLim = size(mat,dim);


if length(bin) == 1 % Input bin is binsize
    binSize = bin; nBin = ceil(binLim/binSize); bin = 0:binSize:nBin*binSize;
else % Input bin is the bin edges
    nBin = length(bin);
end

% Create a cell with
binCell = {nBin};
for i = 1:nBin; binCell{i} = bin(i)+1:bin(i+1); end

% 
if dim==1; outmat = fn_cell2mat(cellfun(@(x)(nanmean(mat(x,:),1)),binCell,'UniformOutput',false) ,1);
elseif dim==2; outmat = fn_cell2mat(cellfun(@(x)(nanmean(mat(:,x),2)),binCell,'UniformOutput',false) ,2);
end



end