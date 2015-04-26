function [patterns labels] = getTrainSet(trainData,range,startRow,endRow)

index = 1;
patterns = cell(1,endRow-startRow+1);
labels = cell(1,endRow-startRow+1);
for i=startRow:endRow
    delta = range(i);
    
    trainSet = trainData(index:index+delta-1,2:end);
    trainLabels = trainData(index:index+delta-1,1);
    index = index+delta;
    temp = {num2cell(trainSet)};
    tempLabels = {num2cell(trainLabels)};
    patterns(i) = temp;
    labels(i) = tempLabels;
end
