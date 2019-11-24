function v = antimedoid(Z,g)
    ind = find(g==1);
    Zg = Z(ind,:);
    d = zeros(length(ind),1);
    for i = 1:length(ind)
        s = 0;
        for j = 1:length(ind)
            s = s + norm(Zg(i,:)-Zg(j,:));
        end
        d(i) = s;
    end
     [~,k] = max(d);
     v = ind(k);
end