%%
tic;
clear;
dataDim = 69;
labelDim = 48;

% dataNumber = 3696; %import data number
dataNumber = 3695;

%load file
fprintf('Loading range.csv\n');
range = csvread('in_data/range.csv');
fprintf('Loading train_sorted.csv\n');
trainData = dlmread('in_data/train_sorted.csv',',',[0 1 sum(range(1:dataNumber)) dataDim+1]);
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

save('W','w')
toc;

%% load W
% load('W.mat');

%% for load test data
number_of_sentences = 592;
inData = csvread('in_data/test_data.csv');
inRange = csvread('in_data/test_range.csv');
inRange = inRange(1,1:end-1);

patterns = getTestSet(inData,inRange,1,number_of_sentences);
fprintf('Load Over!\n');
%%

% predict test data and output
for current_sentence = 1:number_of_sentences
    X = patterns{current_sentence}';
    sequence = predict(w, X);
    if current_sentence == 1
        dlmwrite('out_data/test_out_nomap_notrim.csv',sequence,'delimiter', ',');  
    else
        dlmwrite('out_data/test_out_nomap_notrim.csv',sequence,'-append','delimiter', ',');  
    end
end
fprintf('Predict Over!\n');

