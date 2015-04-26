function patterns = getTrainSet(trainData,range,startRow,endRow)

index = 1;
patterns = cell(1,endRow-startRow+1);
for i=startRow:endRow
    delta = range(i);
    
    trainSet = trainData(index:index+delta-1,2:end);
    index = index+delta;
    temp = {num2cell(trainSet)};
    patterns(i) = temp;
end
