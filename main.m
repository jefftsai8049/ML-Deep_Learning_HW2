%%
matlabpool open local 6;
%%

clear;
dataDim = 69;
labelDim = 48;

featureVector = importFeatureVector('feature_vector.csv',1,100);
observation = featureVector(1:size(featureVector,1),1:dataDim*labelDim);
observation = reshape(observation,labelDim*size(observation,1),[]);
transition = featureVector(1:size(featureVector,1),dataDim*labelDim+1:end);
transition = reshape(transition,labelDim*size(transition,1),[]);

patterns = [observation transition];
patterns = num2cell(patterns',[1 117]);

labels = zeros(labelDim,size(patterns,2))-1;
for j=1:labelDim
    for i=1:size(patterns,2)/labelDim
        labels(j,(i-1)*labelDim+j) = 1;
    end
end
labels = num2cell(labels);
svmParameters(1:labelDim) = struct('patterns',[],'labels',[],'lossFn',[],'constraintFn',[],'featureFn',[],'dimension',[],'verbose',[]);
%%


tic;
parfor j=1:labelDim
    %SVM Initail
    svmParameters(j).patterns = patterns;
    svmParameters(j).labels = labels(j,:);
    svmParameters(j).lossFn = @lossCB ;
    svmParameters(j).constraintFn  = @constraintCB ;
    svmParameters(j).featureFn = @featureCB ;
    svmParameters(j).dimension = dataDim+labelDim ;
    % What ?
    svmParameters(j).verbose = 0 ;
    svmModel(j) = svm_struct_learn(' -c 1.0 -o 1 -v 1 ', svmParameters(j) );
    w(:,j) = svmModel(j).w ;

end
toc;

%%
matlabpool close;