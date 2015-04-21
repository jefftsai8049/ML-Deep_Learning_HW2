function delta = lossCB(param, y, ybar)
  delta = double(y ~= ybar) ;
  if param.verbose
    fprintf('delta = loss(%3d, %3d) = %f\n', y, ybar, delta) ;
  end
end