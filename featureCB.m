function psi = featureCB(param, x, y)
    xNum = cell2mat(x);
    featureVector = getFeatureVector(xNum,y);

    
        
    
  psi = sparse(featureVector);
  
  if param.verbose
    fprintf('w = psi([%8.3f,%8.3f], %3d) = [%8.3f, %8.3f]\n', ...
            x, y, full(psi(1)), full(psi(2))) ;
  end
end