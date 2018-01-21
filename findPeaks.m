function [normPeaksTime, normPeaksVal, filteredSignal, filteredTime] = findPeaks(signalStruct)

cutoffTimeInSec = 25;
samplingFreq = 100;
signalStruct.BP = signalStruct.BP(1:cutoffTimeInSec*samplingFreq);
signalStruct.time = signalStruct.time(1:cutoffTimeInSec*samplingFreq);

%detrend and normalize
detrendedSignal = detrend(signalStruct.BP);
detrendedSignal=detrendedSignal./max(abs(detrendedSignal));


lpFilter = designfilt('lowpassiir','FilterOrder',2, ...
         'PassbandFrequency', 6,'PassbandRipple',0.2, ...
         'SampleRate',samplingFreq);
%fvtool(lpFilter)

lpFiltered = filter(lpFilter, detrendedSignal);
filteredSignal = lpFiltered;
filteredTime = signalStruct.time;

if false
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
end

forceWindowSize = 10;
lpFiltered = [zeros(forceWindowSize/2,1); lpFiltered; zeros(forceWindowSize/2,1)];
time = 0:0.01:length(lpFiltered)*0.01-0.01;

signalForce = ones(length(lpFiltered), 1);
for i=1:length(lpFiltered)-forceWindowSize
    signalForce(i) = sum(abs(lpFiltered(i:i+forceWindowSize)))^2;
end
signalForce=signalForce./max(abs(signalForce));

thWindowSize = 200;
thFrac = 0.25;
freqCutoff = 150;
timeDiffCutoff = 1/freqCutoff*60;
thresholdedSignalForce = [signalForce; zeros(length(signalForce), 1)];
for i = 1:thWindowSize:floor(length(signalForce)/thWindowSize)*thWindowSize+1
    th = thFrac * max(thresholdedSignalForce(i:i+thWindowSize));
    tmp = thresholdedSignalForce(i:i+thWindowSize);
    tmp(tmp < th) = 0;
    thresholdedSignalForce(i:i+thWindowSize) = tmp;
end
thresholdedSignalForce = thresholdedSignalForce(1:length(signalForce));
[peaksVal,peaksTime] = findpeaks(thresholdedSignalForce,time);
normPeaksVal = [];
normPeaksTime = [];

for i = 1:length(peaksVal)
    centerTimeInd = peaksTime(i) * samplingFreq;
    lowerBoundInd = centerTimeInd - forceWindowSize;
    upperBoundInd = centerTimeInd + forceWindowSize;
    if lowerBoundInd < 1 
        lowerBoundInd = 1; end
    if upperBoundInd > length(lpFiltered)
        upperBoundInd = length(lpFiltered); end
   
    [~, maxInd] = max(lpFiltered(lowerBoundInd:upperBoundInd));
    maxInd = maxInd + lowerBoundInd - 1;
    maxInd = round(maxInd);
    if i > 1 && time(maxInd - forceWindowSize/2) - normPeaksTime(length(normPeaksTime)) < timeDiffCutoff
        continue;
    end
    normPeaksVal(length(normPeaksVal)+1) = lpFiltered(maxInd);
    normPeaksTime(length(normPeaksTime) +  1) = time(maxInd - forceWindowSize/2);
end

if false
    figure; 
    subplot(211); plot(time, lpFiltered);
    hold on; subplot(211); plot(time, signalForce, 'r');
    hold on; subplot(211); plot(time, thresholdedSignalForce, 'g');
    hold on; subplot(211); plot(peaksTime, peaksVal, 'rx');
    hold on; subplot(211); plot(normPeaksTime, normPeaksVal, 'kx');
    subplot(212);
    plot(time, lpFiltered); hold on;
    subplot(212); plot(normPeaksTime, normPeaksVal, 'rx');
end

end

