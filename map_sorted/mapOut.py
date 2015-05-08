__author__ = 'jefftsai'

import os

inFile = open('test_out_nomap_notrim.csv','r')
mapOldFile = open('48_idx_chr.map','r')
if inFile.readable():
    print('test_out_nomap_notrim.csv Load OK!')
if mapOldFile.readable():
    print('48_idx_chr.map Load OK!')
mapOldSet = []
while 1:
    mapOldStr = mapOldFile.readline()
    if mapOldStr == '':
        break
    mapOldVec = mapOldStr.split('\t')
    mapOldVec[1] = mapOldVec[1][:-1].split('      ')[0]
    mapOldVec[0],mapOldVec[1] = mapOldVec[1],mapOldVec[0]
    mapOldSet.append(mapOldVec)
    # print(mapOldVec)
mapOld = dict(mapOldSet)
# print(mapOld)

mapNewFile = open('48_idx_chr.map_b','r')
mapNewSet = []

if mapNewFile.readable():
    print('48_idx_chr.map_b Load OK!')
while 1:
    mapNewStr = mapNewFile.readline()
    if mapNewStr == '':
        break
    mapNewVec = mapNewStr.split('\t')
    mapNewVec[1] = mapNewVec[1][:-1].split('      ')[1]
    mapNewVec[1] = mapNewVec[1].replace(" ","")
    # mapNewVec[0],mapNewVec[1] = mapNewVec[1],mapNewVec[0]
    mapNewSet.append(mapNewVec)
    # print(mapNewVec)
mapNew = dict(mapNewSet)
# print(mapNew)

outFile = open('test_out.csv','w')
outFile.write('id,phone_sequence\n')

inFileName = open('test_name.csv','r')
rawFile = open('test.ark','r')

if inFileName.readable():
    print('test_name.csv Load OK!')

LKMFile = open('LKM.csv','w')
LKMFile.write("Id,Prediction\n")
while 1:
    inStr = inFile.readline()
    if inStr == '':
        break
    inSequence = inStr[:-1].split(',')

    fileName = inFileName.readline()[:-1]
    # fileName = fileName.split(',')[0]
    outFile.write(fileName)
    outFile.write(',')
    # print(inSequence)
    sequence = []
    raw = []
    for i in range(len(inSequence)):
        realS = mapOld[inSequence[i]]
        raw.append(realS)
        sequence.append(mapNew[realS])

        data = rawFile.readline().split(" ")
        # print(data[0])
        LKMFile.write(data[0]+",")
        LKMFile.write("".join(realS)+"\n")
    # print(raw)


    temp = []
    minLen = 5
    for i in range(len(sequence)-minLen+1):
        if sequence[i] == sequence[i+1] and sequence[i+1] == sequence[i+2] and sequence[i+2] == sequence[i+3] and sequence[i+3] == sequence[i+4]:
            temp.append(sequence[i])

    sequence = temp
    # print(sequence)



    temp = []
    for i in range(len(sequence)-1):
        if i == 0:
            temp.append(sequence[i])
            # outFile.write(sequence[i])

        if sequence[i] != sequence[i+1]:
            temp.append(sequence[i+1])
            # outFile.write(sequence[i+1])
            # outFile.write(',')

    sequence = temp

    if sequence[0]=="L":
        del sequence[0]
    if sequence[len(sequence)-1] == "L":
        del sequence[len(sequence)-1]
    outFile.write(''.join(sequence)+'\n')
    # print(sequence)
    # print(temp)

print("Save test_out.csv Successful")
os.system("pause")

inFile.close()
mapOldFile.close()
mapNewFile.close()
outFile.close()
rawFile.close()
LKMFile.close()