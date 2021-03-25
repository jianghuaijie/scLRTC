# scLRTC: imputation for single-cell RNA-seq data via low rank tensor completion
scLRTC is a Matlab package for imputing for scRNA-seq. The imputed expression matrix from scLRTC can be used as inputs for other existing scRNA-seq pipelines or tools for downstream analyses, such as cell type clustering, dimension reduction, and visualization.
## Install dependences
scLRTC is implemented in MATLAB (version>=2017a). Please install MATLAB (>=2017a) before running scLRTC.<br>
The downstream analysis is implemented in R (version>=3.6.2). Please install R (>=3.6.2) before running the downstream analysis.<br>
## Usage
### Preprocessing
We recommend that the user filters unwanted genes and cells before recovering raw data. By default, the gene expressed in less than or equal to 3 cells is removed. And we perform log-transform after adding a pseudocount of 1.
> Note: If there is a batch effect in the data, and the batch effect is not caused by dropout, it is recommended that the user removes the batch effect using other software such as [seurat3.0] (https://satijalab.org/seurat/).
### Imputation
scLRTC() is the main function to recovery scRNA-seq data. We provided demo.m file to introduce how to change the parameters used in scLRTC. Here, you’ll get to know how to use scLRTC.
Initially, it begins by cleaning up the Matlab environment:
``` matlab
clc;
clear;
close all;
```
You need to set the input file, a csv format file in which the first columns stores the gene names and the first row the cell names mandatorily.
``` matlab
input_path='YANDATA.csv'; %the dir of input file;
%the filr format should be '.csv',Cell and gene names are mandatory.
M = readtable(input_path,'Delimiter',',','ReadRowNames',1,'ReadVariableNames',1);
M0 = table2array(M);
``` 
Then, some optional parameters can be set as below:
``` matlab
k=5;
%Construct the size of the third-order low-rank tensor
p=5;
%Construct the size of the third-order low-rank tensor
rho=1e-5;
%the initial value of the parameter; it should be small enough
epsilon=1e-2;
%the tolerance of the relative difference of outputs of two neighbor iterations
alpha= [1,1e-2,2e-3];
%the coefficient of the objective function, i.e., \|X\|_* := \alpha_i \|X_{i(i)}\|_*
```
Now, the thing you have to do is to invoke the scLRTC( ) function.
``` matlab
rebuild =scLRTC(M0,k,p,rho,epsilon,alpha);
```
Finally, you need to save the result of imputation.
``` matlab
output_path ='yanltrc.csv';
%the dir of output file
csvwrite(output_path,rebuild);
%save the imputation result
```
## Downstream analysis
We provide the downstream analysis code and it can be found in the "analysis" folder.<br>
If you want to perform the downstream analysis, you can refer to the detailed guide(manual).pdf in https://github.com/jianghuaijie/scLRTC_guide.<br>


## Help
If you have any problem or question using the package please contact 769738064@qq.com.<br>
