close all; clear; clc;
currentFileName = 'GT_F_05_02.txt';
[TS,Resp,BP,ECG] = readFile(['data/' currentFileName]);
signalData.fileName = currentFileName;
signalData.time = TS;
signalData.resp = Resp;
signalData.BP = BP;
signalData.ECG = ECG;

cutoffTimeInSec = 25;
samplingFreq = 100;
signalData.BP = signalData.BP(1:cutoffTimeInSec*samplingFreq);
signalData.time = signalData.time(1:cutoffTimeInSec*samplingFreq);

fs = 100;
%t = 0:1/fs:max(signalData.time);
%signalData.BP = interp1(signalData.time, signalData.BP, t);
%signalData.time = t;

%detrend and normalize
detrendedSignal = detrend(signalData.BP);
detrendedSignal=detrendedSignal./max(abs(detrendedSignal));

lpFilter = designfilt('lowpassiir','FilterOrder',2, ...
         'PassbandFrequency', 6,'PassbandRipple',0.2, ...
         'SampleRate',fs);
%fvtool(lpFilter)

hpFilter = designfilt('highpassiir','FilterOrder',2, ...
         'PassbandFrequency',0.4,'PassbandRipple',0.2, ...
         'SampleRate',fs);
%fvtool(hpFilter)


lpFiltered = filter(lpFilter, detrendedSignal);
hpFiltered = filter(hpFilter, lpFiltered);
hpFilteredO = filter(hpFilter, detrendedSignal);

figure;
subplot(211);
plot(signalData.time, signalData.BP);
hold on;
subplot(212);
plot(signalData.time, detrendedSignal);
hold on;
subplot(212);
plot(signalData.time, lpFiltered, 'r');
hold on;
subplot(212);
plot(signalData.time, hpFiltered, 'g');
hold on;
subplot(212);
plot(signalData.time, hpFilteredO, 'm');

