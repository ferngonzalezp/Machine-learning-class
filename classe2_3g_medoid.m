load dataset1

Z = zscore(A);

x1min = min(Z(:,1));
x1max = max(Z(:,1));
x2min = min(Z(:,2));
x2max = max(Z(:,2));

seed1(1) = x1min + (x1max-x1min)*rand(1);
seed2(1) = x1min + (x1max-x1min)*rand(1);
seed3(1) = x1min + (x1max-x1min)*rand(1);

seed1(2) = x2min + (x2max-x2min)*rand(1);
seed2(2) = x2min + (x2max-x2min)*rand(1);
seed3(2) = x2min + (x2max-x2min)*rand(1);
iter = 0;

while(1)
groupe1 = zeros(size(Z,1),1);
groupe2 = zeros(size(Z,1),1);
groupe3 = zeros(size(Z,1),1);
 d1 = zeros(size(Z,1),1);
 d2 = zeros(size(Z,1),1);
 d3 = zeros(size(Z,1),1);


for i = 1:size(Z,1)
    d1(i) = norm(Z(i,:)-seed1); 
    d2(i) = norm(Z(i,:)-seed2); 
    d3(i) = norm(Z(i,:)-seed3); 
    if d1(i) == min([d1(i),d2(i),d3(i)])
        groupe1(i) = 1;
    elseif d2(i) == min([d1(i),d2(i),d3(i)])
        groupe2(i) = 1;
    else
        groupe3(i) = 1;
    end
end

cluster1 = Z.*groupe1;
cluster2 = Z.*groupe2;
cluster3 = Z.*groupe3;

ind1 = find(groupe1 == 0);
ind2 = find(groupe2 == 0);
ind3 = find(groupe3 == 0);
cluster1(ind1,:) = [];
cluster2(ind2,:) = [];
cluster3(ind3,:) = [];

seed1n = medoid(Z,groupe1) ;
seed2n = medoid(Z,groupe2) ;
seed3n = medoid(Z,groupe3) ;

dist = norm(seed1-seed1n)+norm(seed2-seed2n)+ norm(seed3-seed3n);
iter = iter+1;
seed1 = seed1n;
seed2 = seed2n;
seed3 = seed3n;

if dist <= 1e-6
    break;
end
end

plot(cluster1(:,1),cluster1(:,2), 'or');
hold on
plot(cluster2(:,1),cluster2(:,2), 'xb');
plot(cluster3(:,1),cluster3(:,2), '*m');