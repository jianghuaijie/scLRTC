clc;
clear;
close all;
input_path='YANDATA.csv'; 
%the dir of input file
M = readtable(input_path,'Delimiter',',','ReadRowNames',1,'ReadVariableNames',1);
M0 = table2array(M);
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
rebuild =scLRTC(M0,k,p,rho,epsilon,alpha);
output_path ='yanltrc.csv';
%the dir of output file
csvwrite(output_path,rebuild);
%save the imputation result
fprint('complete!');
