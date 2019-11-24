function d = intragroup(Z,g)
    ind = find(g == 1);
    Zg = Z(ind,:);
    d = inf*ones(size(Z,1),1);
    for i = 1:length(ind)
        s = zeros(length(ind),1);
        for j = 1:length(ind)
            if i == j
                s(j) = inf;
            else
                s(j) = norm(Zg(i,:)-Zg(j,:));
            end
        end
        d(ind(i)) = min(s);
    end
end