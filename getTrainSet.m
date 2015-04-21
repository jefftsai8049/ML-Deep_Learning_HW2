function [patterns labels] = getTrainSet(trainData,range,count)
if count ==1
    from = 1;
    to = sum(range(1:count));

else
    from = sum(range(1:count-1))+1;
    to = sum(range(1:count));
end
trainSet = trainData(from:to,:);
labels = num2cell(trainSet(:,1)');
% Cut patterns
patterns = num2cell(trainSet(:,2:size(trainSet,2))',[1,size(trainSet,2)]);