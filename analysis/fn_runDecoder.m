function decoder = fn_runDecoder(data1,data2, percTrain)
    nNeuron = size(data1,2);
    rep = 100;
    nTrial = size(data1,1);
    nTrain = round (percTrain * nTrial);
    nTest = nTrial - nTrain;
    decoder.cellW = zeros(nNeuron,rep);
    decoder.cellAcc = zeros(nNeuron,rep,2);
    decoder.popW = zeros(nNeuron,rep);
    decoder.popAcc = zeros(rep,2);

    decoder.cellWShuf = zeros(nNeuron,rep);
    decoder.cellAccShuf = zeros(nNeuron,rep,2);
    decoder.popWShuf = zeros(nNeuron,rep);
    decoder.popAccShuf = zeros(rep,2);
    for i = 1:rep
        idxT = randperm(nTrial);
        idxF = randperm(nTrial);
        trainT = data1(idxT(1:nTrain),:);
        trainF = data2(idxF(1:nTrain),:);
        testT = data1(idxT(nTrain+1:end),:);
        testF = data2(idxF(nTrain+1:end),:);

        
        [tempCellW, tempCellAcc,tempPopW,tempPopAcc] = getDecoderW(trainT,trainF,testT,testF);
        decoder.cellW(:,i) = tempCellW; decoder.cellAcc(:,i,:) = tempCellAcc;
        decoder.popW(:,i) = tempPopW; decoder.popAcc(i,:) = tempPopAcc;

        allData = [data1;data2];
        idxR = randperm(nTrial*2);
        trainT = allData(idxR(1:nTrain),:);
        trainF = allData(idxR(nTrain+1:nTrain*2),:);
        testT = allData(idxR(nTrain*2+1:nTrain*2+nTest),:);
        testF = allData(idxR(nTrain*2+nTest+1:end),:);
        [tempCellW, tempCellAcc] = getDecoderW(trainT,trainF,testT,testF);
        decoder.cellWShuf(:,i) = tempCellW; decoder.cellAccShuf(:,i,:) = tempCellAcc;
        decoder.popWShuf(:,i) = tempPopW; decoder.popAccShuf(i,:) = tempPopAcc;
    end
end


function [cellW, cellAcc,popW, popAcc] = getDecoderW(trainT,trainF,testT,testF)
    nTrain = size(trainT,1);
    nTest = size(testT,1);

    nNeuron = size(trainT,2);
    cellW = zeros(nNeuron,1);
    cellAcc = zeros(nNeuron,2);
    popAcc = zeros(1,2);
    for j = 1:nNeuron    
        tempW = (mean(trainT(:,j)) - mean(trainF(:,j))) / (var(trainT(:,j))/2 + var(trainF(:,j))/2);
        cellW(j) = tempW;
        predictT = tempW * trainT(:,j); predictF = tempW * trainF(:,j); 
        c = mean(predictT)/2 + mean(predictF)/2;
        correctT = predictT>c;correctF = predictF<c;
        cellAcc(j,1) = (sum(correctT) + sum(correctF)) / (2*nTrain);
        predictT = tempW * testT(:,j); correctT = predictT>c;
        predictF = tempW * testF(:,j); correctF = predictF<c;
        cellAcc(j,2) = (sum(correctT) + sum(correctF)) / (2*(nTest));
    end
    %warning ('off')
    avgCov = diag(diag(cov(trainT)/2 + cov(trainF)/2));
    tempW = (mean(trainT) - mean(trainF)) / avgCov;
    popW = tempW;
    predictT = trainT * tempW'; predictF = trainF * tempW'; 
    c = mean(predictT)/2 + mean(predictF)/2;
    correctT = predictT>c;correctF = predictF<c;
    popAcc(1) = (sum(correctT) + sum(correctF)) / (2*nTrain);
    predictT = testT * tempW'; predictF = testF * tempW'; 
    correctT = predictT>c;correctF = predictF<c;
    popAcc(2) = (sum(correctT) + sum(correctF)) / (2*(nTest));

end