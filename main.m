close all; clear; clc;

[dataNB, data03, data05] = readAllFiles();
fullData = [dataNB data03 data05];

for i = 1:length(fullData)
    [fullData(i).peaksTime, fullData(i).peaksVal, fullData(i).filteredBP, fullData(i).filteredTime] = findPeaks(fullData(i));
    title(fullData(i).fileName);
    [fullData(i).pOpt, fullData(i).Yhat, fullData(i).MSE, fullData(i).AKAIKE] = estimateFourierSeriesModel(fullData(i));
end

saveToXls(fullData);
