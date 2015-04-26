function psi = featureCB(param, x, y)
    dataDim = 69;
    labelDim = 48;

    sequenceLength = size(y,1);
    featureVector = zeros(labelDim,dataDim+labelDim);

    xNum = cell2mat(x);
%     y = cell2mat(y);
    for i=1:sequenceLength
        featureVector(y(i,1)+1,1:dataDim) = featureVector(y(i,1)+1,1:dataDim)+xNum(i,:); 
        featureVector(y(i,1)+1,dataDim+y(i,1)+1) = featureVector(y(i,1)+1,dataDim+y(i,1)+1)+1;
    end
    featureVector = reshape(featureVector,[dataDim*labelDim+labelDim*labelDim 1]);
        
    
  psi = sparse(featureVector);
  
  if param.verbose
    fprintf('w = psi([%8.3f,%8.3f], %3d) = [%8.3f, %8.3f]\n', ...
            x, y, full(psi(1)), full(psi(2))) ;
  end
end