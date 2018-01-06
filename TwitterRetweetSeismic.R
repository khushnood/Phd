#datasource :http://snap.stanford.edu/seismic/
dirPath="C:\\Users\\khush\\Documents\\data\\twitter SEISMIC"
retIndex=read.csv(file.path(dirPath,"index.csv"))
retweetDataFile=read.csv(file.path(dirPath,"data.csv"))
outPutFilePath=file.path(dirPath,"retweet.txt")
randomRetweets=sample(1: length(retIndex[,1]),5000)
aggreageData=data.frame();
normalizedTweetId=1;
for(singleTweet in randomRetweets){
  detailsAboutSingleTweet=retIndex[singleTweet,]
  detailsAboutTime=cbind(rep(normalizedTweetId,length(detailsAboutSingleTweet[3]$start_ind:detailsAboutSingleTweet[4]$end_ind)),retweetDataFile[detailsAboutSingleTweet[3]$start_ind:detailsAboutSingleTweet[4]$end_ind,1])
  normalizedTweetId=normalizedTweetId+1
  aggreageData=rbind(aggreageData,detailsAboutTime)
}

writableData=cbind(1:length(aggreageData[,1]),aggreageData)
write.csv(writableData[,c(1,2,3)],file = outPutFilePath,row.names=FALSE,sep = "t")
