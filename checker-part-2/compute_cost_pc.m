function [cost] = compute_cost_pc(points, centroids)
    cost = 0;
    n = size(points, 1);
    NC = size(centroids, 1);
    for i = 1 : n
        dmin = inf;
        for j = 1 : NC
            d = sqrt(get_dist_squared(points(i, :), centroids(j, :)));
            if d < dmin
                dmin = d;
            end
        end
        cost = cost + dmin;
    end
end

function [d] = get_dist_squared(a, b)
    n = size(a, 2);
    d = 0;
    for i = 1 : n
        d = d + (a(i) - b(i)) ^ 2;
    end
    %d = sqrt(d);
end