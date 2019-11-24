load dataset1

Z = zscore(A);

seed1 = randn(1,2);
seed2 = randn(1,2);

x1min = min(Z(:,1));
x1max = max(Z(:,1));
x2min = min(Z(:,2));
x2max = max(Z(:,2));

seed1(1) = x1min + (x1max-x1min)*rand(1);
seed2(1) = x1min + (x1max-x1min)*rand(1);

seed1(2) = x2min + (x2max-x2min)*rand(1);
seed2(2) = x2min + (x2max-x2min)*rand(1);
iter = 0;
while(1)
groupe1 = zeros(size(Z,1),1);
groupe2 = zeros(size(Z,1),1);
 d1 = zeros(size(Z,1),1);
 d2 = zeros(size(Z,1),1);

for i = 1:size(Z,1)
    d1(i) = norm(Z(i,:)-seed1); 
    d2(i) = norm(Z(i,:)-seed2); 
    if d1(i) < d2(i)
        groupe1(i) = 1;
    else
        groupe2(i) = 1;
    end
end

cluster1 = Z.*groupe1;
cluster2 = Z.*groupe2;

ind1 = find(groupe1 == 0);
ind2 = find(groupe2 == 0);
cluster1(ind1,:) = [];
cluster2(ind2,:) = [];

seed1n = [mean(cluster1(:,1)) mean(cluster1(:,2))] ;
seed2n = [mean(cluster2(:,1)) mean(cluster2(:,2))];

dist = norm(seed1-seed1n)+norm(seed2-seed2n);
iter = iter+1;
seed1 = seed1n;
seed2 = seed2n;

if dist <= 1e-6
    break;
end
end

plot(cluster1(:,1),cluster1(:,2), 'or');
hold on
plot(cluster2(:,1),cluster2(:,2), 'xb');