
rm(list = ls())
gc()
setwd("C:/Users/jianghuaijie/Desktop/study/bioinformatics/impute/simdif")
lpsdata<-read.table("sim_full.csv",header=T,row.names=1,sep=",",check.names=F)
class.label<- read.table("sim_label.csv", header=T,sep=",",check.names=F) 
class.label<-as.matrix(class.label)
label<- class.label[,2]
library(Seurat)
pbmc <-CreateSeuratObject(counts = lpsdata,project = "pbmc4k",min.cells = 3)

Idents(pbmc)<-label
gene1 <- FindMarkers(pbmc, ident.1 = "Group2", ident.2 = "Group3",test.use = "MAST")

lpsdata1<-read.table("sim_042.csv",header=T,row.names=1,sep=",",check.names=F)
pbmc1 <-CreateSeuratObject(counts = lpsdata1,project = "pbmc42",min.cells = 3)
Idents(pbmc1)<-label
gene2 <- FindMarkers(pbmc1, ident.1 = "Group2", ident.2 = "Group3",test.use = "MAST")

lpsdata2<-read.table("cmfsim042.csv",header=T,row.names=1,sep=",",check.names=F)
pbmc2 <-CreateSeuratObject(counts = lpsdata2,project = "pbmc42",min.cells = 3)
Idents(pbmc2)<-label
gene3 <- FindMarkers(pbmc2, ident.1 = "Group2", ident.2 = "Group3",test.use = "MAST")

lpsdata3<-read.table("sim_042magic.csv",header=T,row.names=1,sep=",",check.names=F)
pbmc3 <-CreateSeuratObject(counts = lpsdata3,project = "pbmc42",min.cells = 3)
Idents(pbmc3)<-label
gene4 <- FindMarkers(pbmc3, ident.1 = "Group2", ident.2 = "Group3",test.use = "MAST")

lpsdata4<-read.table("saversim042.csv",header=T,row.names=1,sep=",",check.names=F)
pbmc4 <-CreateSeuratObject(counts = lpsdata4,project = "pbmc42",min.cells = 3)
Idents(pbmc4)<-label
gene5 <- FindMarkers(pbmc4, ident.1 = "Group2", ident.2 = "Group3",test.use = "MAST")

lpsdata5<-read.table("drimputesim042.csv",header=T,row.names=1,sep=",",check.names=F)
pbmc5 <-CreateSeuratObject(counts = lpsdata5,project = "pbmc42",min.cells = 3)
Idents(pbmc5)<-label
gene6 <- FindMarkers(pbmc5, ident.1 = "Group2", ident.2 = "Group3",test.use = "MAST")

lpsdata6<-read.table("scimpute042scimpute_count.csv",header=T,row.names=1,sep=",",check.names=F)
pbmc6 <-CreateSeuratObject(counts = lpsdata6,project = "pbmc42",min.cells = 3)
Idents(pbmc6)<-label
gene7 <- FindMarkers(pbmc6, ident.1 = "Group2", ident.2 = "Group3",test.use = "MAST")

lpsdata7<-read.table("lrtcsim042.csv",header=T,row.names=1,sep=",",check.names=F)
pbmc7 <-CreateSeuratObject(counts = lpsdata7,project = "pbmc42",min.cells = 3)
Idents(pbmc7)<-label
gene8 <- FindMarkers(pbmc7, ident.1 = "Group2", ident.2 = "Group3",test.use = "MAST")



pVals1 <- p.adjust(as.double(gene1[,1]), method = "fdr")
sigDE1 <- rownames(gene1)[pVals1 < 0.01]

genename<-rownames(lpsdata)
notDE<-setdiff(genename,sigDE1)
GroundTruth <- list(DE=as.character(unlist(sigDE1)), notDE=as.character(unlist(notDE)))


pVals2 <- p.adjust(as.double(gene2[,1]), method = "fdr")
sigDE2 <- rownames(gene2)[gene2['p_val_adj'] < 0.01]
notDE2<-setdiff(genename,sigDE2)
pVals3 <- p.adjust(as.double(gene3[,1]), method = "fdr")
sigDE3 <- rownames(gene3)[gene3['p_val_adj'] < 0.01]
notDE3<-setdiff(genename,sigDE3)
pVals4 <- p.adjust(as.double(gene4[,1]), method = "fdr")
sigDE4 <- rownames(gene4)[gene4['p_val_adj'] < 0.01]
notDE4<-setdiff(genename,sigDE4)
pVals5 <- p.adjust(as.double(gene5[,1]), method = "fdr")
sigDE5 <- rownames(gene5)[gene5['p_val_adj'] < 0.01]
notDE5<-setdiff(genename,sigDE5)
pVals6 <- p.adjust(as.double(gene6[,1]), method = "fdr")
sigDE6 <- rownames(gene6)[gene6['p_val_adj'] < 0.01]
notDE6<-setdiff(genename,sigDE6)
pVals7 <- p.adjust(as.double(gene7[,1]), method = "fdr")
sigDE7 <- rownames(gene7)[gene7['p_val_adj'] < 0.01]
notDE7<-setdiff(genename,sigDE7)
pVals8 <- p.adjust(as.double(gene8[,1]), method = "fdr")
sigDE8 <- rownames(gene8)[gene8['p_val_adj'] < 0.01]
notDE8<-setdiff(genename,sigDE8)



write.csv(gene1,"fullsiggene23.csv")
write.csv(gene2,"dropsiggene23.csv")
write.csv(gene3,"cmfsiggene23.csv")
write.csv(gene4,"magicsiggene23.csv")
write.csv(gene5,"saversiggene23.csv")
write.csv(gene6,"drimputesiggene23.csv")
write.csv(gene7,"scimputesiggene23.csv")
write.csv(gene8,"lrtcsiggene23.csv")