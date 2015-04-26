function [patterns labels] = getTrainSet(trainData,range,startRow,endRow)

index = 1;
patterns = cell(1,endRow-startRow+1);
labels = cell(1,endRow-startRow+1);
for i=startRow:endRow
    delta = range(i);
    patterns(i) = {num2cell(trainData(index:index+delta-1,2:end))};
    labels(i) = {num2cell(trainData(index:index+delta-1,1))};
    index = index+delta;
%     fprintf('Reshapeing...');
%     fprintf(i);
%     fprintf('\n');
end
end
