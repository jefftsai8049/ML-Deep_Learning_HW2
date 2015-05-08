# This script is sorting data and label, and combine it together
# Convert train.ark and train.lab to train_out.txt
import sys

# Load train data train.ark
train = open("F:/jefftsai-lab405/code/ML-Deep_Learning_HW2/data/train.ark","r")
# Load label data train.lab
label = open("F:/jefftsai-lab405/code/ML-Deep_Learning_HW2/data/train.lab","r")
#Load train_out.txt to output comibed train data
out = open("F:/jefftsai-lab405/code/ML-Deep_Learning_HW2/data/train_sorted.csv","w")


mapFile = open("F:/jefftsai-lab405/code/ML-Deep_Learning_HW2/data/48_idx_chr.map","r")


set=[]
while 1:
    mapData = mapFile.readline()
    if mapData == "":
        break
    set.append(mapData.split()[0:2])

map = dict(set)

print(map)


i=0
while 1:
    # Load train.ark line by line
    trainD = train.readline()
    # Check data is end or not
    if trainD == "" :
        #print(i)
        break
    # Split train data
    trainV = trainD.split()

    while 1:
        # Load label line by line
        labelD = label.readline()
        # Check label is end or not
        if labelD == "":
            # If EOF  open label file again
            label = open("F:/jefftsai-lab405/code/ML-Deep_Learning_HW2/data/train.lab","r")
        else:
            # If not EOF, split label
            labelV = labelD.split(',')
            #print(labelV[0])
            #print(labelV[1])
            #print(i)
            # Find same train data and label name
            if trainV[0] == labelV[0]:
                # Cut out the last character "\n"
                labelV[1] = map[labelV[1][:-1]]
                #print(labelV[1])
                # Combine data together
                trainD = labelV[1]+"\t"+trainD
                trainD.replace("\t",",")
                set = trainD.split()
                set[0],set[1] = set[1],set[0]
                msg = ','.join(set)
                msg = msg[:-1]
                # Write data into file
                out.write(msg+"\n")
                break

    i =i+1
    if trainD == "" :
        #print(i)
        break
# Close file
train.close()
label.close()
out.close()

mapFile.close()

