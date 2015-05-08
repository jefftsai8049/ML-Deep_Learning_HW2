__author__ = '靜偉'
import sys
import numpy as np

np.set_printoptions(threshold=np.nan)

dataFile = open("F:/jefftsai-lab405/code/ML-Deep_Learning_HW2/data/train_sorted.csv","r")
mapFile = open("F:/jefftsai-lab405/code/ML-Deep_Learning_HW2/data/48_idx_chr.map","r")
outFile = open("F:/jefftsai-lab405/code/ML-Deep_Learning_HW2/data/feature_vector.csv","w")
sequenceFile = open("F:/jefftsai-lab405/code/ML-Deep_Learning_HW2/data/sequendce.csv","w")
rangeFile = open("F:/jefftsai-lab405/code/ML-Deep_Learning_HW2/data/range.csv","w")

# outFile.write("id")
# outFile.write(",")
# outFile.write("feature")
# outFile.write("\n")
#print(mapFile.readline())
labelDim = 48
dataDim = 69

observation = np.zeros((labelDim,dataDim))

transition = np.zeros((labelDim,labelDim))


set=[]
while 1:
    mapData = mapFile.readline()
    if mapData == "":
        break
    set.append(mapData.split()[0:2])

map = dict(set)

print(map)



# dataFile = open("C:/ML_hw2/data/train_sorted.txt","r")


i=0
while 1:
    set = []
    dataLine = dataFile.readline()
    if dataLine == "":
        break
    # if i>5:
    #     break
    #print("change segmentation  ")
    #print(i)
    data = dataLine.split(",")
    nowName = data[1].split("_")
    set.append(data)
    while 1:
        dataLine = dataFile.readline()
        if dataLine == "":
            set.append(data)
            #print("fucking end")
            break

        data = dataLine.split(",")
        #print(data)
        newName = data[1].split("_")

        if nowName[0]==newName[0] and nowName[1]==newName[1]:
            set.append(data)
        else :
            dataFile.seek(dataFile.tell()-(len(dataLine)+1))
            #print("end")
            break

    # print ("len"+str(len(set)))
    name = set[0][1].split("_")
    sequenceFile.write(name[0]+"_"+name[1]+",")
    for K in range(0,len(set)):
        #print(set[K][0])
        sequenceFile.write(map[set[K][0]])
        if K!=len(set)-1:
            sequenceFile.write(",")

    sequenceFile.write("\n")


    print(set)


    j=0
    while 1:
        if j>len(set)-2:
            break
        # print(map[set[j][0]])
        # tempTs = np.zeros((labelDim,labelDim))
        # temp
        nowLabel = int(map[set[j][0]]) #for matrix position
        nextLabel = int(map[set[j+1][0]])
        transition[nowLabel][nextLabel] = transition[nowLabel][nextLabel]+1

        j=j+1

    l=0
    observation = np.zeros((labelDim,dataDim))
    while 1:
        if l>len(set)-1:
            break
        tempOb = np.zeros((labelDim,dataDim))
        tempOb[int(map[set[l][0]])][:] = set[l][2:dataDim+2]
        observation = observation+tempOb
        l = l+1
        #print(l)
    rangeFile.write(str(l)+",")
    # print(set[0][1])

    # print(name)
    out = {}
    outOb = {}
    outTs = {}
    outOb = np.reshape(observation,(1,labelDim*dataDim))
    outTs = np.reshape(transition,(1,labelDim*labelDim))
    out = np.append(outOb,outTs)

    outFile.write(name[0]+"_"+name[1]+",")

    count = 0
    while 1:
        if count > np.shape(outOb)[1]+np.shape(outTs)[1]-1:
            outFile.write("\n")
            break
        # outFile.write(name[0]+"_"+name[1]+"_"+str(count)+","+str(out[count])+"\n")
        outFile.write(str(out[count])+",")
        count = count +1
    i = i+1
# print(observation)
# print(out)
# print (outOb)

#  outOb = np.reshape(observation,(1,labelDim*dataDim))
# outTs = np.reshape(transition,(1,labelDim*labelDim))
# print(outTs)
# print(out)

rangeFile.close()
sequenceFile.close()
dataFile.close()
mapFile.close()
outFile.close()
