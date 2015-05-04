%{
clear all; clc;

W = rand(69*48+48*48,1);
X = rand(69,100);
%}

%% for load test data
number_of_sentences = 592;

inData = csvread('test_data.csv');
inRange = csvread('test_range.csv');
inRange = inRange(1,1:end-1);

patterns = getTestSet(inData,inRange,1,number_of_sentences);
fprintf('Load Over!\n');
%%
for current_sentence = 1:number_of_sentences
    
    X = patterns{current_sentence}';
%     Y = labels{current_sentence}';
% 
%     number_of_frames = size(X, 2);

    
    sequence = predict(w, X);
%     correctness = correctness + sum(Y == sequence) / number_of_frames;
    if current_sentence == 1
        
        dlmwrite('test_out_nomap_notrim.csv',sequence,'delimiter', ',');  
    else
        dlmwrite('test_out_nomap_notrim.csv',sequence,'-append','delimiter', ',');  
    end
end

% correctness = correctness / number_of_sentences;
% 
fprintf('Predict Over!\n');





