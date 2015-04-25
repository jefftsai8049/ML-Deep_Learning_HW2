function patterns = getTrainSet(trainData,range,startRow,endRow)


for i=startRow:endRow
    delta = range(i);
    trainSet = trainData(1:delta,2:end);
    temp = {num2cell(trainSet)};
end
