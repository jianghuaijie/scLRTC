rm(list = ls())
gc()
library("scater")
library ("cluster")
library("ggplot2")
setwd("C:/Users/jianghuaijie/Desktop/study/bioinformatics/impute/yan")
lpsdata0<-read.table("YANDATA.csv",header=T,row.names=1,sep=",",check.names=F)
truelabel=read.table("yanlabel.csv",header=T,row.names=1,sep=",",check.names=F)
#set.seed(12345)
calcukateSC <- function(lpsdata,label,name1){
  label<-as.matrix(label)
  labelx <-as.factor(label)
  sce <- SingleCellExperiment(assays = list(counts = as.matrix(lpsdata),
                                            logcounts = log2(as.matrix(lpsdata)+1)),
                              colData = label)
  rowData(sce)$feature_symbol <- rownames(sce)
  sce <- sce[!duplicated(rowData(sce)$feature_symbol), ]
  tsnered<-runUMAP(sce)
  tsnepc=tsnered@int_colData@listData[["reducedDims"]]@listData[["UMAP"]]
  tsnepc1 =data.frame(var_x=tsnepc[,1],var_y=tsnepc[,2])
  p<-ggplot(data=tsnepc1, aes(x=var_x, y=var_y,color=labelx)) + geom_point(size=2)+
    theme(plot.title = element_text(hjust = 0.5))
  p<-p+scale_x_discrete("")+scale_y_discrete("")
  p<-p+ theme_set(theme_bw())
  p<-p+theme(panel.grid.major=element_line(colour=NA))
  p<-p+labs(fill="")
  p<-p+theme(legend.position="none")
  dir =paste(name1,".png")
  ggsave(dir, plot = p, device = NULL, path = NULL,
         scale = 1, width = NA, height = NA, units =c("in", "cm", "mm"),
         dpi = 600, limitsize = TRUE)
  dis <- dist(tsnepc1)^2
  #library(fpc)
  label=as.matrix(label)
  sil <- silhouette (label, dis)
  sil=as.matrix(sil)
  avg = mean(sil[,3])
  return (avg)
}

arawsc=calcukateSC(lpsdata0,truelabel,"umapraw")