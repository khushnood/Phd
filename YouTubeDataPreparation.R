source('Utilities.R')
#http://konect.uni-koblenz.de/networks/youtube-u-growth
fileDirectory="C:/Users/khush/Documents/data/youtube-u-growth"
sourceFile=file.path(fileDirectory,"out.youtube-u-growth")
outPutFilePath=file.path(fileDirectory,"youTube_mine.txt")
readFileDataFile=read.csv(file = file.path(sourceFile),sep = " ")
dates <- as.Date( structure(readFileDataFile[,4], class = c("POSIXct", "POSIXt")))
#Min.      1st Qu.       Median         Mean      3rd Qu.         Max. 
#"2006-12-09" "2006-12-09" "2007-04-18" "2007-03-29" "2007-06-20" "2007-07-22"
asDayOfTheYear=getNumberOfDaysFromDateList(dateList=dates)
sampledIndexOnCriteria=vector()
dataSize=length(readFileDataFile[,1])

#users who rated more than 15 movies criteria

#sampledIndexOnCriteria=getIndexAccordingToCriteriaOfOccurenceSingle(readFileDataFile[,1],10)
userIds=readFileDataFile[,1]
randomSelectedDataItems= sample(unique(userIds),30000)
sampledIndexOnCriteria=which(userIds %in% randomSelectedDataItems);


readFileData=cbind(readFileDataFile[sampledIndexOnCriteria,c(1,2)],asDayOfTheYear[sampledIndexOnCriteria])

normalizedNodeColumnData=normalizedNodeIdsInBipartiteNetworks(readFileData[,1],readFileData[,2])
timeStampData=readFileData[,3]
timeDecreasingIndex=order(timeStampData,decreasing = T)
invalidEdgeIndeces=union(which(normalizedNodeColumnData[,1] %in% -1),which(normalizedNodeColumnData[,2] %in% -2))
validIndecesFinal=setdiff(timeDecreasingIndex,invalidEdgeIndeces);
writableData=cbind(normalizedNodeColumnData[validIndecesFinal,1],normalizedNodeColumnData[validIndecesFinal,2],readFileData[validIndecesFinal,3])

write.csv(writableData[,c(1,2,3)],file = outPutFilePath,row.names=FALSE,sep = "t")
printFileDetails(rawData = readFileDataFile,outPutFilePath)