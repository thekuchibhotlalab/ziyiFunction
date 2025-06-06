function trialHistory = fn_getTrialHistory(currTrial, nPrev,tempDayLen)
tempDayLen = [0 cumsum(tempDayLen)];
trialHistory = zeros(length(currTrial),nPrev);
for i = 1:nPrev; trialHistory(:,i) = circshift(currTrial,i); end


for j = 1:length(tempDayLen)-1
    for i = 1:nPrev
        trialHistory(tempDayLen(j)+1:tempDayLen(j)+i,i) = 0;
    end
end

end