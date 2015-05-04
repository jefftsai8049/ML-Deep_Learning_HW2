%%
tic;
clear;
dataDim = 69;
labelDim = 48;

% dataNumber = 3696; %import data number
dataNumber = 100;
%load file
fprintf('Loading range.csv\n');
range = csvread('range.csv');
fprintf('Loading train_sorted.csv\n');
trainData = dlmread('train_sorted.csv',',',[0 1 sum(range(1:dataNumber)) dataDim+1]);
fprintf('Load file ok!\n');



toc;

%reshape file
tic;
fprintf('Reshaping file!\n');
[patterns,labels] = getTrainSet(trainData,range,1,dataNumber);
fprintf('Reshape file ok!\n');
toc;


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
svmModel = svm_struct_learn(' -c 3 -o 2 -v 1 ', svmParameters );
w = svmModel.w ;
toc;

