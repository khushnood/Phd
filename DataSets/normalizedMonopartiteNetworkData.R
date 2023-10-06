
source('C:/Users/thinkpad/OneDrive/Documents/R/Utilities/Utilities.R')

fileDirectory="E:/Abbas/DataSets/timeAsDayTemporal"

sourceFile=file.path(fileDirectory,"citationArxivTimeAsMonth_short.txt")
outPutFilePath=file.path(fileDirectory,"citationArxivTimeAsMonth_short_Processed.txt")
rawData=read.csv(file = file.path(sourceFile),sep = "\t")
readFileDataFile=normalizedNodeIdsInUnipartiteNetworks(rawData[,1],rawData[,2])

write.csv(cbind(readFileDataFile, rawData[,3]),file = outPutFilePath,row.names=FALSE,sep = "\t")