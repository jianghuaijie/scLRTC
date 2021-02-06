## ----knitr-options, echo=FALSE, message=FALSE, warning=FALSE---------------
#rm(list = ls())
rm(list = ls())
gc()
setwd("C:/Users/jianghuaijie/Desktop/study/bioinformatics/impute/yan")
lpsdata<-read.table("YANDATA.csv",header=T,row.names=1,sep=",",check.names=F)
class.label<- read.table("yanlabel.csv", header=T,sep=",",check.names=F) 
class.label<-as.matrix(class.label)
class.label<- class.label[,2]
yan1<-lpsdata
label<-class.label

## ----knitr-options, echo=FALSE, message=FALSE, warning=FALSE---------------
library(knitr)
opts_chunk$set(fig.align = 'center', fig.width = 6, fig.height = 5, dev = 'png')

## ---- message=FALSE, warning=FALSE-----------------------------------------
library(SingleCellExperiment)
library(SC3)
library(scater)
ibrary(mclust)
sce <- SingleCellExperiment(assays = list(counts = as.matrix(yan1),
                                          logcounts = log2(as.matrix(yan1)+1)),
                            colData = label)

# define feature names in feature_symbol column
rowData(sce)$feature_symbol <- rownames(sce)
# remove features with duplicated names
sce <- sce[!duplicated(rowData(sce)$feature_symbol), ]

# define spike-ins
#isSpike(sce, "ERCC") <- grepl("ERCC", rowData(sce)$feature_symbol)

## --------------------------------------------------------------------------
#plotPCA(sce, colour_by = "cell_type1")

## --------------------------------------------------------------------------
 
sce <- sc3(sce,gene_filter = FALSE, ks =9, biology = FALSE)
pre_label <-colData(sce)$sc3_9_clusters
adjustedRandIndex(pre_label, label)
  


