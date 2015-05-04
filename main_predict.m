%{
clear all; clc;

W = rand(69*48+48*48,1);
X = rand(69,100);
%}

number_of_sentences = 100;

correctness = 0;

for current_sentence = 1:number_of_sentences
    
    X = patterns{current_sentence}';
    Y = labels{current_sentence}';

    number_of_frames = size(X, 2);

    
    sequence = predict(w, X);
    correctness = correctness + sum(Y == sequence) / number_of_frames;

    dlmwrite('test_out_nomap_notrim.csv',sequence,'-append','delimiter', ',');  

end

correctness = correctness / number_of_sentences;

fprintf('The correctness is  %f %%.   \n', correctness*100);





