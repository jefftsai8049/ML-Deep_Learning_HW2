%%
tic;
clear;
dataDim = 69;
labelDim = 48;

dataNumber = 3696; %import data number

%load file
fprintf('Loading sequence.csv\n');
sequence = importSequence('sequence.csv',1,dataNumber);
fprintf('Loading range.csv\n');
range = csvread('range.csv');
fprintf('Loading train_sorted.csv\n');
trainData = importTrain('train_sorted.csv',1,sum(range(1:dataNumber)));
toc;
%%
%reshape file
patterns= getTrainSet(trainData,range,1,dataNumber);
labels = cell(1,dataNumber);
for i=1:dataNumber
    temp = sequence(i,:);
    temp = temp(~isnan(temp));
    temp = num2cell(temp',1);
    labels(i) = temp;
end
%%
tic;
%SVM Initail
svmParameters.patterns = patterns;
svmParameters.labels = labels;
svmParameters.lossFn = @lossCB ;
svmParameters.constraintFn  = @constraintCB ;
svmParameters.featureFn = @featureCB ;
svmParameters.dimension = dataDim*labelDim+labelDim*labelDim ;
% What ?
svmParameters.verbose = 0 ;
svmModel = svm_struct_learn(' -c 1.0 -o 2 -v 1 ', svmParameters );
w = svmModel.w ;
toc;

