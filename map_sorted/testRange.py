__author__ = 'jefftsai'
inFile = open('F:/jefftsai-lab405/code/ML-Deep_Learning_HW2/matlab/ML-Deep_Learning_HW2/test.ark','r')
outFile = open('F:/jefftsai-lab405/code/ML-Deep_Learning_HW2/matlab/ML-Deep_Learning_HW2/test_data.csv','w')
rangeFile = open('F:/jefftsai-lab405/code/ML-Deep_Learning_HW2/matlab/ML-Deep_Learning_HW2/test_range.csv','w')
nameFile = open('F:/jefftsai-lab405/code/ML-Deep_Learning_HW2/matlab/ML-Deep_Learning_HW2/test_name.csv','w')

inStr = inFile.readline()
inList = inStr[:-1].split(' ')

# print(inList)
inName = inList[0].split("_")
inVal = inList[1:]
# print(inVal)
# print(inName)


valSet = []
while 1:
    if len(inName)<2:
        break
    nameFile.write(inName[0]+"_"+inName[1]+"\n")
    count = 1
    while 1:
        # print(inList)
        inStr = inFile.readline()
        inList = inStr[:-1].split(" ")
        inName_next = inList[0].split("_")
        inVal_next = inList[1:]

        if inName[0] == inName_next[0] and inName[1] == inName_next[1]:
            valSet.append(inVal)
            outFile.write(','.join(inVal))
            outFile.write("\n")
            inName = inName_next
            inVal = inVal_next
        else:
            valSet.append(inVal)
            outFile.write(','.join(inVal))
            outFile.write("\n")
            inName = inName_next
            inVal = inVal_next
            break
        count = count + 1
    rangeFile.write(str(count)+",")


outFile.close()
inFile.close()
rangeFile.close()
nameFile.close()
