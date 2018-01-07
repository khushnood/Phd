source('Utilities.R')

fileDirectory="C:/Users/khush/Documents/data/"
sourceFile=file.path(fileDirectory,"ratings.csv")
outPutFilePath=file.path(fileDirectory,"ouputFile.txt")
rawData=read.csv(file = file.path(sourceFile),sep = ",")
readFileDataFile=rawData[rawData[,3]>2,] #Rating greater than two criteria
dates <- as.Date( structure(readFileDataFile[,4], class = c("POSIXct", "POSIXt")))
asDayOfTheYear=getNumberOfDaysFromDateList(dateList=dates)
sampledIndexOnCriteria=vector()
dataSize=length(readFileDataFile[,1])
#sampledIndexOnCriteria=getIndexAccordingToCriteriaOfOccurenceSingle(readFileDataFile[,1],10)
userIds=readFileDataFile[,1]
randomSelectedDataItems= sample(unique(userIds),10000) #Selected 10,000 random users who rated the movies
sampledIndexOnCriteria=which(userIds %in% randomSelectedDataItems);
readFileData=cbind(readFileDataFile[sampledIndexOnCriteria,c(1,2)],asDayOfTheYear[sampledIndexOnCriteria])
normalizedNodeColumnData=normalizedNodeIdsInBipartiteNetworks(readFileData[,1],readFileData[,2])
timeStampData=readFileData[,3]
timeDecreasingIndex=order(timeStampData,decreasing = T)
invalidEdgeIndeces=union(which(normalizedNodeColumnData[,1] %in% -1),which(normalizedNodeColumnData[,2] %in% -2))
validIndecesFinal=setdiff(timeDecreasingIndex,invalidEdgeIndeces);
writableData=cbind(normalizedNodeColumnData[validIndecesFinal,1],normalizedNodeColumnData[validIndecesFinal,2],readFileData[validIndecesFinal,3])

write.csv(writableData[,c(1,2,3)],file = outPutFilePath,row.names=FALSE,sep = "\t")

