function [markcell] = scLRTC(data,k,p,rho,epsilon,alpha)
processed_data=process(data);
[m,t] =size(processed_data');
%Calculating Euclidean distance of cells
D=pdist(processed_data','correlation');
score =squareform(D);
[as,pos]=sort(score,1,'descend');
[m,n]=size(score);
topk =pos(1:k-1,:);
for i=1:m
part_data{i}=processed_data(:,[i;topk(:,i)]);
end
%Calculating Euclidean distance of cells
euk =zeros(k,m);
for i=1:m
    eud=pdist(part_data{i}','euclidean');
    scoreeuk =squareform(eud);
    euk(:,i)=scoreeuk(1,:)';
end
cosk =zeros(k,m);
%Calculating cosine distance of cells
for i=1:m
    cosd=pdist(part_data{i}','cosine');
    scorecos =squareform(cosd);
    cosk(:,i)=scorecos(1,:)';
end
cosk=sort(cosk,1);
%Calculating Chebyshev distance of cells
chebk =zeros(k,m);
for i=1:m
    chebd=pdist(part_data{i}','chebychev');
    scorecheb =squareform(chebd);
    chebk(:,i)=scorecheb(1,:)';
end
chebk=sort(chebk,1);
%Calculating distance feature mat
for i=1:m
    mat(:,i)=[euk(:,i);cosk(:,i);chebk(:,i)];
end
matdistance=pdist(mat','euclidean');
matdistance =squareform(matdistance);
[as2,pos2]=sort(matdistance,1,'descend');
topp =pos2(1:p-1,:);
% Construct a third-order low-rank tensor and reconstruct
markcell=[];
for i=1:m
temp =[i;topp(:,i)];
tensors=[part_data{temp}];
tensor1 =reshape(tensors,[t,k,p]);
rho = rho;
epsilon =epsilon;
alpha = alpha;
alpha = alpha / sum(alpha);
maxIter =500;
[X_H, errList_H] = ADMMLRTC(tensor1,find(tensor1~=0),alpha,rho,maxIter,epsilon);

markcell =[markcell,X_H(:,1,1)];
end
markcell(markcell<0)=0;
markcell = max(2.^(markcell)-1,0);