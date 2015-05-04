function patterns = getTestSet(trainData,range,startRow,endRow)

index = 1;
patterns = cell(1,endRow-startRow+1);
labels = cell(1,endRow-startRow+1);
for i=startRow:endRow
    delta = range(i);
    patterns(i) = {trainData(index:index+delta-1,2:end)};
    labels(i) = {trainData(index:index+delta-1,1)};
    index = index+delta;
%     fprintf('Reshapeing...');
%     fprintf(i);
%     fprintf('\n');
end
end

inData = csvread('test_data.csv');
inRange = csvread('test_range.csv');

% nameFile = dlmread('test.ark',' ',[0 1 dataNumber-1 2]);

% 
%%


% X = zeros(size(s,1),size(s,2)-2);
% for i=1:size(s,2)-2
%     X(i) = str2double(cell2mat(s(:,i+1)))
% end

% fclose(testFile);