function saveToXls(fullData)
resultHeaderes = {'fileName' 'breathProcedure' 'furierSerModelRank'};
%resultFilesName = ones(length(fullData), 1);
%resultBreathProc = ones(length(fullData), 1);
%resultFurierModelRank = ones(length(fullData), 1);

for i = 1:length(fullData)
    resultFilesName{i} = fullData(i).fileName;
    resultBreathProc{i} = fullData(i).breathProc;
    resultFurierModelRank{i} = fullData(i).pOpt;
end

dataToSave = [resultHeaderes;
    resultFilesName' resultBreathProc' resultFurierModelRank'];

xlswrite('result.xls', dataToSave);
end
