function [onIdx, offIdx,blockIdx,blockArea,blockMax] = fn_getBlockOnOff(inFlag,inArray, lenThre)

if size(inFlag,2) == 1;inFlag= inFlag'; end 
if nargin >= 1; lenThre = 1; end; if nargin == 1; inArray = inFlag; end 
if size(inArray,2) == 1;inArray= inArray'; end 
inFlag = [0 inFlag 0];    

tempDiff = diff(inFlag); tempLen = [];

blockOn = (tempDiff==1); blockOn = blockOn(1:end-1);
blockOff = (tempDiff==-1); blockOff = blockOff(2:end);

blockIdx = {};blockArea = [];blockMax = [];onIdx = find(blockOn); offIdx = find(blockOff);
for i = 1:length(onIdx)
    blockIdx{i} = onIdx(i):offIdx(i); tempLen(i) = length(blockIdx{i});
    blockArea(i) = abs(sum(inArray(blockIdx{i})));
    blockMax(i) = max(abs(inArray(blockIdx{i})));
end

% select the blocks that have a minimum length
selFlag = tempLen >= lenThre;
onIdx = onIdx(selFlag);
offIdx = offIdx(selFlag);
blockIdx = blockIdx(selFlag);


end