##DataSource #http://konect.uni-koblenz.de/networks/digg-votes
source('Utilities.R')
fileDirectory="C:/Users/khush/Documents/data/digg-votes/digg-votes"
sourceFile=file.path(fileDirectory,"out.digg-votes")
outPutFilePath=file.path(fileDirectory,"diggVoting.txt")
readFileDataFile=read.csv(file = file.path(sourceFile),sep = " ")
unixTime= structure(readFileDataFile[,4], class = c("POSIXct", "POSIXt"))
asDayOfTheYear=getHourOfDaysFromUnixTimeStampList(unixTime)
sampledIndexOnCriteria=vector()
dataSize=length(readFileDataFile[,1])
readFileData=cbind(readFileDataFile[,c(1,2)],asHourOfDays)
normalizedNodeColumnData=normalizedNodeIdsInBipartiteNetworks(readFileData[,1],readFileData[,2])
timeStampData=readFileData[,3]
timeDecreasingIndex=order(timeStampData,decreasing = T)
invalidEdgeIndeces=union(which(normalizedNodeColumnData[,1] %in% -1),which(normalizedNodeColumnData[,2] %in% -2))
validIndecesFinal=setdiff(timeDecreasingIndex,invalidEdgeIndeces);
writableData=cbind(normalizedNodeColumnData[validIndecesFinal,1],normalizedNodeColumnData[validIndecesFinal,2],readFileData[validIndecesFinal,3])
write.csv(writableData[,c(1,2,3)],file = outPutFilePath,row.names=FALSE,sep = "t")
