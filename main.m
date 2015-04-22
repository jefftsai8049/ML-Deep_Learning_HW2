%%
% Load file

% Load Sequence Length
range = csvread('range.csv');
% Load Train data  
% trainData = importTrain('train_sorted.csv',1,inf);
% (if load all data )
trainData = importTrain('train_sorted.csv',1,1000);
featureVector = importFeatureVector('feature_vector.csv',1,1);
[patterns labels] = getTrainSet(trainData,range,1,1);
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
w = svmModel.w ;
