close all; clear; clc;

[dataNB, data03, data05] = readAllFiles();

fullData = [dataNB data03 data05];

for i = 1:numel(fullData)
    plotAdSignal(fullData(i))
end