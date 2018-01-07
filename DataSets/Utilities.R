getNumberOfDaysFromDateList<-function(dateList){
  require("zoo")
  asDayOfTheYear<-as.numeric(format(as.Date(dateList), format = "%j"))
  getTheYear<-as.numeric(format(as.Date(dateList), format = "%Y"))
  numberOfYearsFromBeginig<-getTheYear-min(getTheYear)
  startDayOfTheYear=as.numeric(format(as.Date(min(dateList[getTheYear==min(getTheYear)])), format = "%j"))
 for(theYear in unique(getTheYear)){
  if(theYear>min(getTheYear)){
   asDayOfTheYear[getTheYear==theYear]=asDayOfTheYear[getTheYear==theYear]+365*(theYear-min(getTheYear));
 }
 }
  asDayOfTheYear=asDayOfTheYear-startDayOfTheYear;
  
   return(asDayOfTheYear)
}

getNumberOfMonthFromDateList<-function(dateList){
  require("zoo")
  asMonthOfTheYear<-as.numeric(format(as.Date(dateList), format = "%m"))
  getTheYear<-as.numeric(format(as.Date(dateList), format = "%Y"))
  
  startDayOfTheYear=min(getTheYear)
 mormalizedYear=getTheYear-startDayOfTheYear;
 startMonthOfYear=as.numeric(format(as.Date(min(dateList[getTheYear==min(getTheYear)])), format = "%m"))

 asMonthOfTheYear=asMonthOfTheYear+(12*mormalizedYear)-startMonthOfYear
  
  return(asMonthOfTheYear)
}


#This method does not cosider montsh we can consider in it month later
getHourOfDaysFromUnixTimeStampList<-function(unixTimeList){
  hourDay=cbind(unclass(as.POSIXlt(unixTimeList))$hour,unclass(as.POSIXlt(unixTimeList))$mday,unclass(as.POSIXlt(unixTimeList))$mon)
  minDay=min(hourDay[,2])
  normalizedDays=hourDay[,2]-minDay
  numberOfHours=normalizedDays*24
  cumulativeDas=hourDay[,1]+numberOfHours
  return(cumulativeDas)
}

##
## this method gives rating matrix over time here time column considered as 4th
##

#This method for analysiding data
# goodfit(x, type = c("poisson", "binomial", "nbinomial"),
# method = c("ML", "MinChisq"), par = NULL)
# ## S3 method for class 'goodfit'
# predict(object, newcount = NULL, type = c("response", "prob"), ...)
# ## S3 method for class 'goodfit'
# residuals(object, type = c("pearson", "deviance",
#                            "raw"), ...)
# ## S3 method for class 'goodfit'
# print(x, residuals_type = c("pearson", "deviance",
#                             "raw"), ...)

distributionFitting<-function(univariateData,distributionType="Poisson",testMethod="MinChisq"){
  require(vcd)
  require(MASS)
  require(stats)
  library(tseries)
  library(nortest)
  x.dist=fitdistr(univariateData, distributionType)
  x.poi=rpois(length(trainSet),lambda =x.dist$vcov[1])
  print(x.dist$vcov[1])
  gf<-goodfit(x.poi,type= "poisson",method= testMethod)
  plot(gf)
  #shapiro.test(univariateData)
  jarque.bera.test(univariateData)
  cvm.test(univariateData)
  
  return(gf)
}
normalizeData<-function(data){
  #  data[data==0]=1
  meanNormalize=(data-min(data))/(max(data)-min(data))
  
  return(meanNormalize)
}


## example > 

calculatePercentage<-function(bigg,small){
  return((as.vector(bigg)-as.vector(small))*100/small)
}
normalizeData<-function(data){
  #  data[data==0]=1
  meanNormalize=(data-min(data))/(max(data)-min(data))
  
  return(meanNormalize)
}

##This is for normalizing nodeIds in unipartite networks
normalizedNodeIdsInUnipartiteNetworks<-function(sourceNodeColumn,targetNodeColumn){
  uniqueNodeIds=union(sourceNodeColumn,targetNodeColumn)
  numberOfNodes=length(uniqueNodeIds)
  numberOfEdges=length(sourceNodeColumn)
  fromNodeIds=rep(-1,numberOfEdges)
  toNodeIds=rep(-2,numberOfEdges)
  
  for(nodeIdIndx in 1:numberOfNodes){
    nodeLabel=uniqueNodeIds[nodeIdIndx]
    fromNodeIds[which(sourceNodeColumn %in% nodeLabel)]=nodeIdIndx;#here i #assiging an integer to node lable for calculation purpose.
    toNodeIds[which(targetNodeColumn %in% nodeLabel)]=nodeIdIndx;
    
  }
  return(cbind(fromNodeIds,toNodeIds))
}

normalizedNodeIdsInBipartiteNetworks<-function(sourceNodeColumn,targetNodeColumn){
  numberOfEdges=length(sourceNodeColumn)
# % occurenceIndexVector=which(targetNodeColumn %in% nodeLabel)
  
  fromNodeIds=rep(-1,numberOfEdges)
  toNodeIds=rep(-2,numberOfEdges)
  uniqueNodeIds=unique(targetNodeColumn)
  numberOfTargetNodes=length(uniqueNodeIds)
  for(nodeIdIndx in 1:numberOfTargetNodes){
    nodeLabel=uniqueNodeIds[nodeIdIndx]
    toNodeIds[which(targetNodeColumn %in% nodeLabel)]=nodeIdIndx;
    
  }
  
  uniqueNodeIds=unique(sourceNodeColumn)
  for(nodeIdIndx in 1:length(uniqueNodeIds)){ #for from NodeIds
    nodeLabel=uniqueNodeIds[nodeIdIndx]
    fromNodeIds[which(sourceNodeColumn %in% nodeLabel)]=numberOfTargetNodes+nodeIdIndx; #In case of bipartite network userid and itme id should be different
    
  }
 return(cbind(fromNodeIds,toNodeIds))
  
}

getKendallsRankCorrelationTauA<-function(predictedScor,actualScore){
  
  tiesInPredicted=0;
  tiesInActual=0;
  totalCount=0;
  discordant=0;
  concardant=0;
  tau=0;
  predictedValidScores=predictedValidScores/sum(predictedValidScores)
  actualValidScores=actualValidScores/sum(actualValidScores)
  
  for(i in seq(2,length(actualValidScores))){
    for(j in seq(1,i-1)){
      
      if (((Double.compare(predictedValidScores[i],
                           predictedValidScores[j]) == -1) && (Double.compare(
                             actualValidScores[i], actualValidScores[j]) == -1))
          || ((Double.compare(predictedValidScores[i],
                              predictedValidScores[j]) == 1) && (Double.compare(actualValidScores[i],
                                                                                actualValidScores[j]) == 1))) {
        concardant=concardant+1;
      }
      if (((Double.compare(predictedValidScores[i],
                           predictedValidScores[j]) == -1) && (Double.compare(
                             actualValidScores[i], actualValidScores[j]) == 1))
          || ((Double.compare(predictedValidScores[i],
                              predictedValidScores[j]) == 1) && (Double.compare(actualValidScores[i],
                                                                                actualValidScores[j]) == -1))) {
        discordant=discordant+1;
      }
      
      
      totalCount=totalCount+1;
    }
  }
  tau=(concardant-discordant)/(totalCount)
  return(tau)
  
  
}
getIndexAccordingToCriteriaOfOccurenceSingle<-function(dataVector,occurenceCriteria){
  sampledIndex=vector()
  uniqueVector=unique(dataVector)
  for(item in uniqueVector){
  occurenceIndexVector=which(dataVector %in% item)
  if(length(occurenceIndexVector)>=occurenceCriteria){
    sampledIndex=union(sampledIndex,occurenceIndexVector)
  } 
    }
  return(sort(sampledIndex))
}
getIndexAccordingToCriteriaOfOccurence<-function(dataVector,occurenceCriteria,randomSelectionCriteria){
  sampledIndex=vector()
  uniqueVector=unique(dataVector)
  itemSetThoseWhoFullFillTheCriteria=vector()
  for(item in uniqueVector){
    occurenceIndexVector=which(dataVector %in% item)
    if(length(occurenceIndexVector)>=occurenceCriteria){
      sampledIndex=union(sampledIndex,(occurenceIndexVector))
      itemSetThoseWhoFullFillTheCriteria=c(itemSetThoseWhoFullFillTheCriteria,item)
    }
  }
  if(length(itemSetThoseWhoFullFillTheCriteria)<randomSelectionCriteria){
    randomSelectionCriteria=length(itemSetThoseWhoFullFillTheCriteria)
    finalSampleAfterApplyingFilter=sampledIndex;
  }
  else{
    randomSelectedDataItems= sample(itemSetThoseWhoFullFillTheCriteria,randomSelectionCriteria)
    finalSampleAfterApplyingFilter=which(dataVector %in% randomSelectedDataItems);
  }
  
  
  return((finalSampleAfterApplyingFilter))
}
Double.compare<-function(a,b){
  
  if(a==b){
    return(0)
  }
  else if (a<b){
    return(-1)
  }
  else {
    return (1)
  }
}

getLifeSpanOfEachNode<-function(nodeIds,time){
  uniqueNodes=unique(nodeIds)
  lifeSpanVector=vector()
  #nodeIdAndTimeSpanlist=list()
  for(node in uniqueNodes){
    sampledIndexOnCriteria=which(nodeIds %in% node);
    lifeSpanVector=c(lifeSpanVector,((max(time[sampledIndexOnCriteria])-min(time[sampledIndexOnCriteria]))+1))
    #nodeIdAndTimeSpanlist=c(nodeIdAndTimeSpanlist,list(nodeid=node,timeSpan=time[sampledIndexOnCriteria])) 
  }
  lifeSpanVector[is.na(lifeSpanVector)]=0
  return(lifeSpanVector)
}

