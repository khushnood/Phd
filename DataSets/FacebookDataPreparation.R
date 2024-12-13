source('Utilities.R')
#http://konect.uni-koblenz.de/networks/facebook-wosn-wall
fileDirectory="C:/Users/khush/Documents/data/facebook-wosn-wall"
sourceFile=file.path(fileDirectory,"out.facebook-wosn-wall")
outPutFilePath=file.path(fileDirectory,"facebook_mine.txt")
readFileDataFile=read.csv(file = file.path(sourceFile),sep = " ")
dates <- as.Date( structure(readFileDataFile[,4], class = c("POSIXct", "POSIXt")))
asDayOfTheYear=getNumberOfDaysFromDateList(dateList=dates)
sortedAccordingtoDescendingDate=order(asDayOfTheYear,decreasing = TRUE)
#appply self influence condition
notOnOwnWall=readFileDataFile[,1]!=readFileDataFile[,2]
readFileData=cbind(readFileDataFile[notOnOwnWall,c(1,2)],asDayOfTheYear[notOnOwnWall])

normalizedNodeColumnData=normalizedNodeIdsInBipartiteNetworks(readFileData[,1],readFileData[,2])
timeStampData=readFileData[,3]
timeDecreasingIndex=order(timeStampData,decreasing = T)
invalidEdgeIndeces=union(which(normalizedNodeColumnData[,1] %in% -1),which(normalizedNodeColumnData[,2] %in% -2))
validIndecesFinal=setdiff(timeDecreasingIndex,invalidEdgeIndeces);
writableData=cbind(normalizedNodeColumnData[validIndecesFinal,1],normalizedNodeColumnData[validIndecesFinal,2],readFileData[validIndecesFinal,3])

write.csv(writableData[,c(1,2,3)],file = outPutFilePath,row.names=FALSE,sep = "t")
printFileDetails(rawData = readFileDataFile,outPutFilePath)

#[1] "No of Unique users40981"
#[1] "No of Unique items38143"
#[1] "total link: 855541"
#[1] "timeInformation: "        Min.      1st Qu.       Median         Mean      3rd Qu.         Max. 
#                         "2004-10-14" "2007-07-14" "2008-03-12" "2008-02-01" "2008-10-02" "2009-01-22" 
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#0    1004    1246    1208    1450    1559 
#[1] " Average life of each item: "
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#1       9     138     295     522    1534 : sampled data
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 1.0   505.0   797.0   740.9  1055.0  1553.0 : Complete data
lifeSpan=getLifeSpanOfEachNode(readFileData[,2],asDayOfTheYear)
summary(lifeSpan)
getDateFromJsonInAPSCitationData <- function(doi){
  tmp= unlist(strsplit(doi, "/"))
  splittedPath= unlist(strsplit(tmp[2], "\\."))
  
  
  # jsonmetafilePath=list.files(path=metaFilesPath,pattern = paste0(tmp[2],".json$"), recursive = TRUE)
  filePath=paste(metaFilesPath,splittedPath[1],splittedPath[2],paste0(tmp[2],".json"),sep = "\\")
  if(file.exists(filePath)){
    result <- fromJSON(file =filePath )
    completeDate=result$date
    completeDate=result$date
    splittedDate= unlist(strsplit(completeDate, "\\-"))
    return(splittedDate[1])
  }
  else{
    return("-1")
  }
  
  convertToAdjacencyMatrix<-function(edgeList){
    size=max(edgeList)
    mat = matrix(0L,nrow=size, ncol=size)
    for(item in seq(1,length(size))){
      i=edgeList[item,1]
      j=edgeList[item,2]
      mat[i][j]=1;
      
      
    }
    return(mat)
  }
  
}
