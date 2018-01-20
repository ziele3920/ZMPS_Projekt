close all; clear; clc;
currentFileName = 'BS_N_NB_03.txt';
[TS,Resp,BP,ECG] = readFile(['data/' currentFileName]);
signalData.fileName = currentFileName;
signalData.time = TS;
signalData.resp = Resp;
signalData.BP = BP;
signalData.ECG = ECG;

[signalData.peaksTime, signalData.peaksVal, signalData.filteredBP, signalData.filteredTime] = findPeaks(signalData);

figure;  plot(signalData.filteredTime, signalData.filteredBP); hold on;
plot(signalData.peaksTime, signalData.peaksVal, 'rx');

