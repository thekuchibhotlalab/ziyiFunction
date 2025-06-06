function [mat,cellSize] = fn_cell2matFast(C,dim)

if nargin == 1; dim = 1; end

mat = [];
cellSize = zeros(2,length(C));

if dim == 1
    mat = nan(length(C),length(C{1}));
elseif dim == 2
    mat = nan(length(C{1},length(C)));
end


for i = 1:length(C)
    tempC = C{i};
    if dim == 1; mat(i,:) = tempC;
    elseif dim == 2; mat(:,i) = tempC;
    end
    cellSize(:,i) = size(C{i});
end

end