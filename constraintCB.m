function yhat = constraintCB(param, model, x, y)
% slack resaling: argmax_y delta(yi, y) (1 + <psi(x,y), w> - <psi(x,yi), w>)
% margin rescaling: argmax_y delta(yi, y) + <psi(x,y), w>
    dataDim = 69;
    labelDim = 48;
    sequenceLength = size(y,1);
    
    
    
   
    wR = reshape(model.w(1:dataDim*labelDim,:),[labelDim dataDim]);  %48x69
    xR = reshape(cell2mat(x),[dataDim sequenceLength]);  %69*dataNumber
    probability = wR*xR; %48xdataNumber
    wT = reshape(model.w(dataDim*labelDim+1:end),[labelDim labelDim]); %48x48
    
    route=[ones(48,sequenceLength)]; %48xsequence
    delta = probability(:,1); %48x1
    for i=1:sequenceLength-1
        p = repmat(delta,1,labelDim)+wT; %48x48
        [dummy,suspect] = max(p); %1x48
        delta = dummy'+ probability(:,i+1); %48x1
        route(:,i+1) = suspect'; %48xi
%        
    end
%     
    [dummy,endNode] = max(delta); %final node 
    yhat = zeros(sequenceLength,1); %initial 
    temp = route(endNode,end); 
    yhat(1,1) = temp;
    for j=2:sequenceLength
        temp = route(temp,end+1-j);
        yhat(j,1) = temp;
    end
    yhat = flipud(yhat-1);
    
%     yhat = 10;
  if param.verbose
    fprintf('yhat = violslack([%8.3f,%8.3f], [%8.3f,%8.3f], %3d) = %3d\n', ...
            model.w, x, y, yhat) ;
  end
end