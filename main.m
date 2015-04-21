%%
% Load file

% Load Sequence Length
range = csvread('range.csv');
% Load Train data  
% trainData = importTrain('train_sorted.csv',1,inf);
% (if load all data )
trainData = importTrain('train_sorted.csv',1,1000);
% Cut a Set (a segment)
% trainSet = getTrainSet(trainData,range,1);
% Cut labels
% labels = num2cell(trainSet(:,1)');
% Cut patterns
% patterns = num2cell(trainSet(:,2:size(trainSet,2))',[1,size(trainSet,2)]);

[patterns labels] = getTrainSet(trainData,range,1);
%%
%Initail GPU Device
gpu = gpuDevice;


%%
%SVM Initail
svmParameters.patterns = patterns;
svmParameters.labels = labels;
svmParameters.lossFn = @lossCB ;
svmParameters.constraintFn  = @constraintCB ;
svmParameters.featureFn = @featureCB ;
svmParameters.dimension = 69 ;
% What ?
svmParameters.verbose = 1 ;
svmModel = svm_struct_learn(' -c 1.0 -o 1 -v 1 ', svmParameters) ;
w = model.w ;
