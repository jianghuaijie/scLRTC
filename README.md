# scLRTC: imputation for single-cell RNA-seq data via low rank tensor completion
scLRTC is a Matlab package for imputing for scRNA-seq.The imputed expression matrix from scLRTC can be used for as inputs for other existing scRNA-seq pipelines or tools for downstream analyses, such as cell type clustering, dimension reduction, and visualization.
# Usage
If want to use our program you can refer the demo we provide.<br>  
If you want to run the demo we provide.<br> 
STEP 1. Download the source codes and unzip the MATLAB package. Change the current directory in MATLAB to the folder containing the scripts.<br> 
STEP 2. Open demo.m ,and click run button to get the result.<br> 
then it will generate a CSV file. In this case it called "yanltrc.csv" (rows are genes and columns are cells).<br> 
If you have not used Matlab (version>=2017a) or R, you can refer to the detailed guide(manual).pdf in https://github.com/jianghuaijie/scLRTC_guide.<br>
If you want to use other datasets,copy the csv file to this folder , change the file name and parameters in the demo.m file,click run button to get the result.
# Downstream analysis
We provide part of the downstream analysis code and it can be found in the "analysis" folder.<br>
If you want to downstream analysis, you can refer to the detailed guide(manual).pdf in https://github.com/jianghuaijie/scLRTC_guide.<br>
# Install dependences
scLRTC is implemented in  and MATLAB(>2017a). Please install MATLAB(>2017a) before run scLRTC. 
# Help
If you have any problem or question using the package please contact lizhong@zstu.edu.cn
