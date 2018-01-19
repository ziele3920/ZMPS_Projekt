close all; clc; clear;
path = 'data/';
filesDetails = dir('data/*.txt');
dupa = filesDetails(3, 1).name;
pp = readFile([path dupa]);

for i = 1:numel(filesDetails)
    data(i).fileName = filesDetails(i, 1).name;
    [TS,Resp,BP,ECG] = readFile([path data(i).fileName]);
    data(i).resp = Resp;
    data(i).BP = BP;
    data(i).ECG = ECG;
end