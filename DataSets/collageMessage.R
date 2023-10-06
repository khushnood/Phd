
source('C:/Users/pc/OneDrive/Documents/R/Utilities/Utilities.R')
#http://files.grouplens.org/datasets/movielens/ml-20m.zip
fileDirectory="E:\\Abbas\\Research\\codes\\GraphNodeRepresentationlearningAll\\tNodeEmbed-master\\data\\COLLMN"
sourceFile=file.path(fileDirectory,"CollegeMsg.txt")
outPutFilePath=file.path(fileDirectory,"CollegeMsgProcessed.txt")
rawData=read.csv(file = file.path(sourceFile),sep = ",")
readFileDataFile=rawData
dates <- as.Date( structure(readFileDataFile[,3], class = c("POSIXct", "POSIXt")))
asDayOfTheYear=getNumberOfDaysFromDateList(dateList=dates)
writableData=cbind(rawData[,c(1,2)],asDayOfTheYear)
write.csv(writableData[,c(1,2,3)],file = outPutFilePath,row.names=FALSE,sep = "\t")

