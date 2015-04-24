%%
matlabpool open local 6;
%%

clear;
dataDim = 69;
labelDim = 48;

featureVector = importFeatureVector('feature_vector.csv',1,100);
patterns = num2cell(featureVector',[1 size(featureVector,1)]);
sequence = importSequence('sequence.csv',1,100);

labels = {};
for i=1:size(featureVector,1)
    temp = sequence(i,:);
    temp = temp(~isnan(temp));
    temp = num2cell(temp',1);

    labels = [labels temp];
end
% svmParameters(1:labelDim) = struct('patterns',[],'labels',[],'lossFn',[],'constraintFn',[],'featureFn',[],'dimension',[],'verbose',[]);
%%


tic;
% parfor j=1:labelDim
    %SVM Initail
    svmParameters.patterns = patterns;
    svmParameters.labels = labels;
    svmParameters.lossFn = @lossCB ;
    svmParameters.constraintFn  = @constraintCB ;
    svmParameters.featureFn = @featureCB ;
    svmParameters.dimension = dataDim*labelDim+labelDim*labelDim ;
    % What ?
    svmParameters.verbose = 0 ;
    svmModel = svm_struct_learn(' -c 1.0 -o 1 -v 1 ', svmParameters );
    w = svmModel.w ;

% end
toc;

%%
matlabpool close;