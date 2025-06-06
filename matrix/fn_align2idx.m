function [tempMat,maxAlignPoint] = fn_align2idx(mat, alignIdx,varargin)
    p = fn_inputParser();
    p.parse(varargin{:});
    attachDim = 2; 
    maxAlignPoint = max(alignIdx);
    tempMatSize = size(mat);
    tempMatSize(attachDim) = tempMatSize(attachDim) + maxAlignPoint;
    tempMat = nan(tempMatSize);
    for j = 1:length(alignIdx)
        startPoint = maxAlignPoint-alignIdx(j)+1;
        endPoint = startPoint+size(mat,attachDim)-1;
        tempMat(j,startPoint:endPoint) = mat(j,:);
        if strcmp(p.Results.fill,'startEndValue')
            try tempMat(j,1:startPoint-1) = mat(j,1);
            catch; end
            try tempMat(j,endPoint+1:end) = mat(j,end);
            catch; end
        end
        
    end
end

function p = fn_inputParser()
    p = inputParser;
    p.KeepUnmatched = true;
    arg = {'fill';'Nan'};
    cellfun(@(x,y)(p.addParameter(x,y)),arg(1,:),arg(2,:));
end 