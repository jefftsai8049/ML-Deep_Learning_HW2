%{
clear all; clc;

W = rand(69*48+48*48,1);
X = rand(69,100);
%}

number_of_sentences = 1000;

correctness = 0;

for current_sentence = 1:number_of_sentences
    
    X = patterns{current_sentence}';
    Y = labels{current_sentence}';

    number_of_frames = size(X, 2);

    %rng(0,'twister');
    %Y = randi([0 47],1,number_of_frames);
    
    sequence = predict(w, X);
%     sum(Y == sequence)
    correctness = correctness + sum(Y == sequence) / number_of_frames;
    
end

correctness = correctness / number_of_sentences;

fprintf('The correctness is  %f %%.   \n', correctness*100);




