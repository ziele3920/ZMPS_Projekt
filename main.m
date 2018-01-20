close all; clear; clc;

[dataNB, data03, data05] = readAllFiles();

fullData = [dataNB data03 data05];

for i = 1:length(fullData)
    [fullData(i).peaksTime, fullData(i).peaksVal, fullData(i).filteredBP, fullData(i).filteredTime] = findPeaks(fullData(i));
    figure;  plot(fullData(i).filteredTime, fullData(i).filteredBP); hold on;
    plot(fullData(i).peaksTime, fullData(i).peaksVal, 'rx');
    title(fullData(i).fileName);
end
%for i = 1:numel(fullData)
%    plotAdSignal(fullData(i))
%end