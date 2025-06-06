function fn_sortByPeakIdx(mat,frameSel)
    frameSel = 11:20;
    [peakValue,peakFrames] = max(mat(frameSel,:),[],1);
    [~,sortIndex] = sort(peakFrames);
    mat = mat()
end