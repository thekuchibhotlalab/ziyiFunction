function [rocAuc,rocAucZscore] = fn_roc(data1, data2)

nShuffle = 100;
rocAct = [data1(:)' data2(:)'];
rocLabel = [zeros(1,numel(data1)) ones(1,numel(data2))];
[tpr, fpr, threshold] = roc(rocLabel, rocAct);
rocAuc = trapz([0 fpr 1],[0 tpr 1]);
tempFpr = find(fpr<0.05);
%rocTpr = tpr(tempFpr(end));
shuffAuc = zeros(1,nShuffle);
for k = 1:nShuffle
    shuffLabel = rocLabel(randperm(length(rocLabel)));
    [tprShuff, fprShuff, thresholdShuff] = roc(shuffLabel, rocAct);
    shuffAuc(k) = trapz([0 fprShuff 1],[0 tprShuff 1]);
end
rocAucZscore = (rocAuc - mean(shuffAuc)) / std(shuffAuc);


end