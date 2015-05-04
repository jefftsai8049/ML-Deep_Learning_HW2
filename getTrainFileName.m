function trainDataName = getTrainFileName(fileName,dataNumber)


file = textread(fileName,'%s', dataNumber);
trainDataName = cell(size(file),1);
for i = 1:size(file)
     temp= strsplit(file{i},',');
     trainDataName(i,1) = cellstr(temp{1});
%     whos temp
end
end