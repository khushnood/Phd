AggregateColumnFromDifferetFiles<-function(directoryPath,fileName,directorySeq=seq(1,2),columnindx,outPutFileName,lenghtOfValidFile=300 ){
  columnIndexMatch=c("TP","TF","AUC_50","AUC_100","AUC_200","Tau","Pn_50","Pn_100","Pn_200","Qn_50","Qn_100","Qn_200","Tqn_50","TQn_100","TQn200")
  noOfLines=50 #movilens:36289, facebook:37025
  aggregatedData=data.frame()
  outPutFilePath=file.path(directoryPath,"HeatMapCombinedout",paste0(columnIndexMatch[columnindx],"_",outPutFileName))
  if(!dir.exists(file.path(directoryPath,"HeatMapCombinedout"))){
    dir.create(file.path(directoryPath,"HeatMapCombinedout"))
  }
  notExistedFiles=list()
  overWrittenFile=list()
  underWrittenFile=list()
  listOfTfs=list()
  fileNotComplet=FALSE
  
  for(directoryIndx in directorySeq ){
    fullFilePath=file.path(directoryPath,directoryIndx,"var",fileName);
    fileInforDetails=file.info(fullFilePath)
  
    if(!file.exists(fullFilePath)){
      notExistedFiles=c(notExistedFiles,fullFilePath)
      fileNotComplet=TRUE
  
    }
    else if (file.exists(fullFilePath)){
      dataRead=read.csv(fullFilePath,sep = "\t",header = FALSE)
      dataRead=dataRead[order(dataRead[,1],decreasing = F),] ###Order by column 1 incase it was written out of place.
      if(length(dataRead[,1])>lenghtOfValidFile){
        overWrittenFile=c(overWrittenFile,fullFilePath)
        fileNotComplet=TRUE
      }
      else if (length(dataRead[,1])<lenghtOfValidFile){
        underWrittenFile=c(underWrittenFile,fullFilePath)
        fileNotComplet=TRUE
        
      } 
    }
   
    
    if(!fileNotComplet){
      
      if(directoryIndx==directorySeq[1]){
        aggregatedData=dataRead[,columnindx]
      }
      else{
        aggregatedData=cbind(aggregatedData,dataRead[,columnindx])
      }
      
    }
  
    write.csv(aggregatedData,file = outPutFilePath,row.names=FALSE,sep = "\t")
    
  } 
  
  if(fileNotComplet){
    message("some error occured")
    return(list(underWrittenFile=underWrittenFile,overWrittenFile=overWrittenFile,notExistedFiles=notExistedFiles))
  }
  else{
    return(TRUE)
  }
}


#########Example 
#For FB the output directory is as old one
 dirPath="C:\\Users\\khush\\OneDrive\\Documents\\cpp\\PopularityPredictionJava\\result\\nonParamRetestHeatMapML20M\\"
 fileName="accuracy__UNKNOWM_4_MOVIELENS_20M.txt"
 columnindx=11
outPutFileName="ML20MCombined.txt"
lenghtOfValidFile=300

#outResult=AggregateColumnFromDifferetFiles(directoryPath = dirPath,directorySeq = seq(1,lenghtOfValidFile),columnindx = 8,outPutFileName = outPutFileName,fileName = fileName,lenghtOfValidFile=lenghtOfValidFile)

for(accurIndx in c(4,6,8,11,14)){
  
  result=AggregateColumnFromDifferetFiles(directoryPath = dirPath,directorySeq = seq(1,lenghtOfValidFile),columnindx = accurIndx,outPutFileName = outPutFileName,fileName = fileName,lenghtOfValidFile=lenghtOfValidFile)
  
} 
print(result)
