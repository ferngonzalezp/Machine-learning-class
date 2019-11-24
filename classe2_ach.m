clc
clear
close all
load dataset1
Z = zscore(A);

groupe1 = ones(size(Z,1),1);
am = antimedoid(Z,groupe1);
groupe2 = zeros(size(groupe1));
groupe2(am) = 1;
groupe1(am) = 0;

iter = 0;
d = intragroup(Z,groupe1);

for i =1:size(Z,1)
    if i ~= am
        if norm(Z(i,:)-Z(am,:)) < d(i)
            groupe2(i) = 1;
            groupe1(i) = 0;
        end
    end
end

cluster1 = Z.*groupe1;
cluster2 = Z.*groupe2;

ind1 = find(groupe1 == 0);
ind2 = find(groupe2 == 0);
cluster1(ind1,:) = [];
cluster2(ind2,:) = [];


plot(cluster1(:,1),cluster1(:,2), 'or');
hold on
plot(cluster2(:,1),cluster2(:,2), 'xb');
figure(2)
hold on
idx = kmedoids(Z,2);
plot(Z(idx==1,1),Z(idx==1,2), 'or')
plot(Z(idx==2,1),Z(idx==2,2), 'xb')
figure(3)
hold on
idx = kmeans(Z,2);
plot(Z(idx==1,1),Z(idx==1,2), 'or')
plot(Z(idx==2,1),Z(idx==2,2), 'xb')