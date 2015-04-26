function delta = lossCB(param, y, ybar)

  delta = sum(~(y==ybar))/size(y,1);
 
  if param.verbose
    fprintf('delta = loss(%3d, %3d) = %f\n', y, ybar, delta) ;
  end
end