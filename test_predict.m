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
   
    sequence = predict(w, X);
    if current_sentence == 1
        
        dlmwrite('test_out_nomap_notrim.csv',sequence,'delimiter', ',');  
    else
        dlmwrite('test_out_nomap_notrim.csv',sequence,'-append','delimiter', ',');  
    end
end
fprintf('Predict Over!\n');
