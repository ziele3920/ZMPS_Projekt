close all; clear; clc;
currentFileName = 'GT_N_03_04.txt';
[TS,Resp,BP,ECG] = readFile(['data/' currentFileName]);
signalData.fileName = currentFileName;
signalData.time = TS;
signalData.resp = Resp;
signalData.BP = BP;
signalData.ECG = ECG;

cutoffTimeInSec = 30;
samplingFreq = 100;
signalData.BP = signalData.BP(1:cutoffTimeInSec*samplingFreq);
signalData.time = signalData.time(1:cutoffTimeInSec*samplingFreq);

fs = 200;
t = 0:1/fs:max(signalData.time);
signalData.BP = interp1(signalData.time, signalData.BP, t);
signalData.time = t;

%detrend and normalize
detrendedSignal = detrend(signalData.BP);
detrendedSignal=detrendedSignal./max(abs(detrendedSignal));

lpFilter = designfilt('lowpassiir','FilterOrder',8, ...
         'PassbandFrequency', 6,'PassbandRipple',0.2, ...
         'SampleRate',fs);
%fvtool(lpFilter)

hpFilter = designfilt('highpassiir','FilterOrder',8, ...
         'PassbandFrequency',0.8,'PassbandRipple',0.2, ...
         'SampleRate',fs);
fvtool(hpFilter)


lpFiltered = filter(lpFilter, detrendedSignal);
hpFiltered = filter(hpFilter, lpFiltered);

figure;
subplot(311);
plot(signalData.time, signalData.BP);
hold on;
subplot(312);
plot(signalData.time, detrendedSignal);
hold on;
subplot(313);
plot(signalData.time, hpFiltered);

