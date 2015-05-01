function yhat = constraintCB(param, model, x, y)
% slack resaling: argmax_y delta(yi, y) (1 + <psi(x,y), w> - <psi(x,yi), w>)
% margin rescaling: argmax_y delta(yi, y) + <psi(x,y), w>
    %dataDim = 69;
    %labelDim = 48;
        
    W = model.w;
        
    X = x';  % transpose of x'
    
    alpha = 0.1;
    
    number_of_phonemes = size(X, 2);       % X should be a 69 x n matrix, each column is a phoneme
    path = zeros(48);                      % each row is a path for each ending node in Viterbi Algorithm  (path is backwards!!)
    path_last = path;
    prob = zeros(48,1);                    % 48 x 1 vector which saves probability for each ending node
    prob_last = prob;
    
    % W is a vector of length 69*48 + 48*48        
    W_observe = reshape(W(1:69*48), 69, 48);      % W_observe are 48 vectors of length 69 corresponding to Wa, Wb, ......
    W_trans = reshape(W(69*48+1:end), 48, 48);     % W_observe are 48 vectors of length 48 corresponding to Waa, Wab, ......
    
    %=========== initialize first column ================
    path = (1:48)';                          % path is backwards! 
    path_last = path;
    
    for current_node = 1:48                 
        prob(current_node) = W_observe(:, current_node)' * X(:, 1);
        prob = prob + alpha;    % add delta y to all nodes
        prob(y(1) + 1) = prob(y(1) + 1) - alpha;  % except the one that is correct    
        prob_last = prob;              
    end
     
    %============= Viterbi ============== 

    for current_phoneme = 1:number_of_phonemes-1
        path = zeros(48, current_phoneme + 1);
        prob_temp = zeros(48, 1);
        for current_node = 1:48      
            prob_temp = prob_last + W_trans(current_node, :)';   % 48 x 1 vector 
            [value, node_coming] = max(prob_temp);               
            prob(current_node) = value + W_observe(:, current_node)' * X(:, current_phoneme + 1);           
            path(current_node, :) = [current_node  path_last(node_coming, :)];
        end
        
        prob = prob + alpha;    % add delta y to all nodes
        prob(y(current_phoneme+1) + 1) = prob(y(current_phoneme+1) + 1) - alpha;  % except the one that is correct    
        
        path_last = path;    
        prob_last = prob;
    end
    
    [dummy, which_node] = max(prob);

    reverse_sequence = path(which_node, :);
    
    sequence = fliplr(reverse_sequence) - 1;  % -1 to map from 1~48 to 0~47 
    
    yhat = sequence';
    

      if param.verbose
        fprintf('yhat = violslack([%8.3f,%8.3f], [%8.3f,%8.3f], %3d) = %3d\n', ...
                model.w, x, y, yhat) ;
      end
end