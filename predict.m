function [ sequence ] = predict( W, X)
    
    number_of_phonemes = size(X, 2);       % X should be a 69 x n matrix, each column is a phoneme
    path = zeros(48);                      % each row is a path for each ending node in Viterbi Algorithm  (path is backwards!!)
    path_last = path;
    prob = zeros(48,1);                    % 48 x 1 vector which saves probability for each ending node
    prob_last = prob;
    
    W_copy = W;                            % copy of W, W is a vector of length 69*48 + 48*48
    W_observe = zeros(69, 48);    
    W_trans = zeros(48, 48); 
    
    for k = 1:48
        W_observe(:, k) = W_copy(1:69);    % W_observe are 48 vectors of length 69 corresponding to Wa, Wb, ......
        W_copy = W_copy(70:end);
    end   

    for k = 1:48
        W_trans(:, k) = W_copy(1:48);     % W_observe are 48 vectors of length 48 corresponding to Waa, Wab, ......
        W_copy = W_copy(49:end);
    end   
    
    %=========== initialize first column ================
    path = (1:48)';                          % path is backwards! 
    path_last = path;
    
    for current_node = 1:48                 
        prob(current_node) = W_observe(:, current_node)' * X(:, 1);
        prob_last = prob;              
    end
     
    %============= Viterbi ============== 

    for current_phoneme = 1:number_of_phonemes-1
        path = zeros(48, current_phoneme + 1);
        prob_temp = zeros(48, 1);
        for current_node = 1:48      
            prob_temp = prob_last + W_trans(current_node, :)';   % 48 x 1 vector 
            [value node_coming] = max(prob_temp);               
            prob(current_node) = value + W_observe(:, current_node)' * X(:, current_phoneme + 1);           
            path(current_node, :) = [current_node  path_last(node_coming, :)];
        end
        path_last = path;    
        prob_last = prob;
    end
    
    [dummy which_node] = max(prob);

    reverse_sequence = path(which_node, :);
    
    sequence = fliplr(reverse_sequence) - 1;  % -1 to map from 1~48 to 0~47 
    
    
    %{ 
    current_phoneme = 1;
    
    while current_phoneme ~= number_of_phonemes 
        if sequence(current_phoneme) == sequence(current_phoneme + 1)
            sequence(current_phoneme) = [];
            number_of_phonemes = number_of_phonemes - 1;
        else
            current_phoneme = current_phoneme + 1;            
        end       
    end
    %}
end

