function patterns = getTestSet(trainData,range,startRow,endRow)

index = 1;
patterns = cell(1,endRow-startRow+1);
% labels = cell(1,endRow-startRow+1);
for i=startRow:endRow
    delta = range(i);
    patterns(i) = {trainData(index:index+delta-1,:)};
%     labels(i) = {trainData(index:index+delta-1,1)};
    index = index+delta;
%     fprintf('Reshapeing...');
%     fprintf(i);
%     fprintf('\n');
end
end
