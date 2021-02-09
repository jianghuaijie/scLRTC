
rm(list = ls())
gc()
library(devtools)
library(mclust)
library(Rtsne)
setwd("/Users/jianghuaijie/Desktop/study/bioinformatics/impute/uso")
lpsdata<-read.table("uso.csv",header=T,row.names=1,sep=",",check.names=F)
class.label<- read.table("usotruelabel.csv", header=T,sep=",",check.names=F) 
class.label<-as.matrix(class.label)
class.label<-class.label[,2]
lpsdata =log2(lpsdata+1)
lpsdata=as.matrix(lpsdata)
arisum=array(0,dim=c(20,1))

labelsum <- matrix(1:12440,ncol=20)
for(i in 1:20){ 
  jiangwei = Rtsne(t(as.matrix(lpsdata)),dim=2,10)$Y
  temp = kmeans(t(as.matrix(lpsdata)), centers = 4)$cluster
  arisum[i]=adjustedRandIndex(temp, class.label);
  labelsum[,i]=temp
}
write.csv(arisum,'usorawari.csv')
write.csv(labelsum,'usorawlabel.csv')