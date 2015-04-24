function yhat = constraintCB(param, model, x, y)
% slack resaling: argmax_y delta(yi, y) (1 + <psi(x,y), w> - <psi(x,yi), w>)
% margin rescaling: argmax_y delta(yi, y) + <psi(x,y), w>
%   if dot(y*x, model.w) > 1
%       yhat = y ; 
%   else
%       yhat = - y ; 
%   end
% 
    dataDim = 69;
    labelDim = 48;
    sequenceLength = size(y,1);
    
    
    wR = reshape(model.w(1:dataDim*labelDim,:),[labelDim dataDim]);  %48x69
    xR = reshape(x(1:dataDim*labelDim,:),[dataDim labelDim]);  %69*48
    probability = wR*xR; %48x48
    wT = reshape(model.w(dataDim*labelDim+1:end),[labelDim labelDim]); %48x48
    
    route=[ones(48,1)];
    delta = probability(:,1); %48x1
    for i=1:sequenceLength-1
        p = remat(delta,labelDim)+wT; %48x48
        [dummy suspect] = max(p); %1x48
        delta = dummy'+ probability(:,i+1); %48x1
        route = [route suspect']; %48x1
       
    end
    
    [dummy endNode] = max(delta);
    temp = route(endNode,end);
    yhat = [];
    yhat = [yhat temp];
    for j=2:sequenceLength
        temp = route(temp,end+1-j);
        yhat = [yhat temp];
    end
    yhat = fliplr(yhat-1);
  if param.verbose
    fprintf('yhat = violslack([%8.3f,%8.3f], [%8.3f,%8.3f], %3d) = %3d\n', ...
            model.w, x, y, yhat) ;
  end
end