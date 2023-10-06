
source('C:/Users/thinkpad/OneDrive/Documents/R/Utilities/Utilities.R')
library(rjson)
library(hashmap)

fileDirectory="E:\\Abbas\\DataSets\\apsCitation"
metaFilesPath="E:\\Abbas\\DataSets\\apsCitation\\aps-dataset-metadata-2017"
##Format: citing_doi, cited_doi
sourceFile=file.path(fileDirectory,"aps-dataset-citations-2017.csv")
#sourceFile=file.path(fileDirectory,"test.csv")
outPutFilePath=file.path(fileDirectory,"apsCitation4ColProcessed.txt")
notRecognizedDois=file.path(fileDirectory,"notRecognizedDois.txt")
rawData=read.csv(file = file.path(sourceFile),sep = ",")
readFileDataFile=normalizedNodeIdsInUnipartiteNetworks(as.vector(rawData[,1]),as.vector(rawData[,2]))
allPublicationDois=as.vector(unique(rawData[,1]))

numberOfPublications=length(rawData[,1])
allDates=vector()
set.seed(123)
#H <- hashmap()

map <- new.env(hash=T, parent=emptyenv())

for(doi in allPublicationDois){
  publicationDate=getDateFromJsonInAPSCitationData(doi)
 allDates=cbind(allDates,publicationDate);
 
}
doiDateMap <- hashmap(keys=allPublicationDois, allDates)
writableData=cbind(readFileDataFile,doiDateMap[[as.vector(rawData[,1])]],doiDateMap[[as.vector(rawData[,2])]])
validIndex= writableData[,3] > 0
write.csv(writableData[validIndex,c(1,2,3,4)],file = outPutFilePath,row.names=FALSE,sep = "t")

#print(doiDateMap$keys()[which(doiDateMap$values() == -1)])

notRecognizedDoisData=doiDateMap$keys()[which(doiDateMap$values() == -1)]
write.csv(notRecognizedDoisData,file = notRecognizedDois,row.names=FALSE,sep = "\t")