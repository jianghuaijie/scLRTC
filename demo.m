M = readtable('YANDATA.csv','Delimiter',',','ReadRowNames',1,'ReadVariableNames',1);
M0 = table2array(M);
k=5;
p=5;
rho=1e-4;
epsilon=1e-3;
alpha= [1,1e-2,2e-3];
rebuild =scLRTC(M0,k,p,rho,epsilon,alpha);
csvwrite('yanltrc.csv',rebuild);
