load dataset1

Z = linkage(A,'complete','chebychev');
C = cluster(Z,'Maxclust', 2);

plot(A(C==1,1),A(C==1,2), 'or')
hold on
plot(A(C==2,1),A(C==2,2), 'xb')