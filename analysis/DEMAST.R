
rm(list = ls())
gc()
setwd("C:/Users/jianghuaijie/Desktop/study/bioinformatics/impute/simdif")
lpsdata<-read.table("sim_full.csv",header=T,row.names=1,sep=",",check.names=F)
class.label<- read.table("sim_label.csv", header=T,sep=",",check.names=F) 
class.label<-as.matrix(class.label)
label<- class.label[,2]
library(Seurat)
pbmc <-CreateSeuratObject(counts = lpsdata,project = "simdata",min.cells = 3)

Idents(pbmc)<-label
gene1 <- FindMarkers(pbmc, ident.1 = "Group2", ident.2 = "Group3",test.use = "MAST")
sigDE <- rownames(gene1)[gene1['p_val_adj'] < 0.01]

genename<-rownames(lpsdata)
notDE<-setdiff(genename,sigDE1)

write.csv(sigDE,"fullsiggene23.csv")
write.csv(notDE,"fullnotsiggene23.csv")