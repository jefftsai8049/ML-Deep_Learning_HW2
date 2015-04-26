function featureVector = getFeatureVector(xNum,y)

    dataDim = 69;
    labelDim = 48;
    sequenceLength = size(y,1);
    temp = zeros(labelDim,dataDim+labelDim);

%     whos y
%     whos xNum
%     whos temp
%     y = cell2mat(y);
    for i=1:sequenceLength-1
        temp(y(i,1)+1,1:dataDim) = temp(y(i,1)+1,1:dataDim)+xNum(i,:); 
        temp(y(i,1)+1,dataDim+y(i+1,1)+1) = temp(y(i,1)+1,dataDim+y(i+1,1)+1)+1;
    end
    %featureVector = reshape(featureVector,[dataDim*labelDim+labelDim*labelDim 1]);
    featureVector = zeros(1,dataDim*labelDim+labelDim*labelDim);
    featureVector(1,1:dataDim*labelDim) = reshape(temp(:,1:dataDim)',[1 labelDim*dataDim]);
    featureVector(1,dataDim*labelDim+1:end) = reshape(temp(:,dataDim+1:end)',[1 labelDim*labelDim]);
    
end