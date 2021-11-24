function decoder = fn_runLDA(tActTrial,fActTrial,xvalidT,xvalidF)
    decoder.nNeuron = size(tActTrial,1);
    decoder.meanT = nanmean(tActTrial,2); decoder.meanF = nanmean(fActTrial,2);
    covT = cov(tActTrial'); covF = cov(fActTrial');
    varT = diag(diag(covT)); varF = diag(diag(covF)); 
    decoder.varMean = (varT + varF) / 2;
    decoder.w = (decoder.varMean) \ (decoder.meanT - decoder.meanF);
    decoder.c = decoder.w' * (decoder.meanT + decoder.meanF) / 2; 
    results = runDecorder(decoder, tActTrial,fActTrial);
    decoder = catstruct(decoder,results);
    if exist('xvalidT')
        xvalid = runDecorder(decoder, xvalidT,xvalidF);decoder.xvalid = xvalid;
    end
end
function results = runDecorder(decoder, T,F)
    if ~isempty(decoder.w)
        if exist('F')
            results.projT = decoder.w' * T - decoder.c; results.predT = results.projT > 0;
            results.projF = decoder.w' * F - decoder.c; results.predF = results.projF <= 0;
            results.acc = nanmean([results.predT results.predF]);
        else
            results.proj = decoder.w' * T - decoder.c; 
            results.predT = results.proj > 0; results.predF = results.proj <= 0;
        end
    else
        if exist('F')
            results.projT = nan(1,size(T,2)); results.projF = nan(1,size(F,2));
            results.acc = nan;
        else
            results.proj = nan(1,size(T,2));
            results.predT = nan(1,size(T,2));
        end
    end
end