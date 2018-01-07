source('Utilities.R')
#http://konect.uni-koblenz.de/networks/lastfm_song
fileDirectory="C:/Users/khush/Documents/data/lastFM/lastfm_song"
sourceFile=file.path(fileDirectory,"out.lastfm_song")
outPutFilePath=file.path(fileDirectory,"lastfm_mine.txt")
readFileDataFile=read.csv(file = file.path(sourceFile),sep = " ")
#readFileDataFile=readFileDataFile[readFileDataFile[,3]>2,] #Rating greater than two criteria
readFileDataFile=read.csv(file = file.path(sourceFile),sep = " ")
dates <- as.Date( structure(readFileDataFile[,4], class = c("POSIXct", "POSIXt")))
asDayOfTheYear=getNumberOfDaysFromDateList(dateList=dates)
sampledIndexOnCriteria=vector()
dataSize=length(readFileDataFile[,1])

#users who rated more than 15 movies criteria

#sampledIndexOnCriteria=getIndexAccordingToCriteriaOfOccurenceSingle(readFileDataFile[,1],10)
userIds=readFileDataFile[,1]
randomSelectedDataItems= sample(unique(userIds),10000) #Selected 10,000 random users who rated the movies
#sampledIndexOnCriteria=which(userIds %in% randomSelectedDataItems);
sampledIndexOnCriteria=getIndexAccordingToCriteriaOfOccurenceSingle(readFileDataFile[,1],10,500)#select the users who have rated more than 10 songs.

readFileData=cbind(readFileDataFile[sampledIndexOnCriteria,c(1,2)],asDayOfTheYear[sampledIndexOnCriteria])

normalizedNodeColumnData=normalizedNodeIdsInBipartiteNetworks(readFileData[,1],readFileData[,2])
timeStampData=readFileData[,3]
timeDecreasingIndex=order(timeStampData,decreasing = T)
invalidEdgeIndeces=union(which(normalizedNodeColumnData[,1] %in% -1),which(normalizedNodeColumnData[,2] %in% -2))
validIndecesFinal=setdiff(timeDecreasingIndex,invalidEdgeIndeces);
writableData=cbind(normalizedNodeColumnData[validIndecesFinal,1],normalizedNodeColumnData[validIndecesFinal,2],readFileData[validIndecesFinal,3])

write.csv(writableData[,c(1,2,3)],file = outPutFilePath,row.names=FALSE,sep = "t")
printFileDetails(rawData = readFileDataFile,outPutFilePath)
