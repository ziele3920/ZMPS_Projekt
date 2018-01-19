function [dataNB, data03, data05] = readAllFiles()
path = 'data/';
filesDetails = dir('data/*.txt');
fileNameDelimiter = '_';
groupIndicatorPos = 3;
dataNB = [];
data03 = [];
data05 = [];

for i = 1:numel(filesDetails)
    currentFileName = filesDetails(i, 1).name;
    splitedFileName = strsplit(currentFileName, fileNameDelimiter);
    [TS,Resp,BP,ECG] = readFile([path currentFileName]);
    if strcmp(splitedFileName(groupIndicatorPos), 'NB')
        dataNB(length(dataNB)+1).fileName = currentFileName;
        dataNB(length(dataNB)).time = TS;
        dataNB(length(dataNB)).resp = Resp;
        dataNB(length(dataNB)).BP = BP;
        dataNB(length(dataNB)).ECG = ECG;
    elseif strcmp(splitedFileName(groupIndicatorPos), '03')
        data03(length(data03)+1).fileName = currentFileName;
        data03(length(data03)).time = TS;
        data03(length(data03)).resp = Resp;
        data03(length(data03)).BP = BP;
        data03(length(data03)).ECG = ECG;
    elseif strcmp(splitedFileName(groupIndicatorPos), '05')
        data05(length(data05) + 1).fileName = currentFileName;
        data05(length(data05)).time = TS;
        data05(length(data05)).resp = Resp;
        data05(length(data05)).BP = BP;
        data05(length(data05)).ECG = ECG;
    end
end
end