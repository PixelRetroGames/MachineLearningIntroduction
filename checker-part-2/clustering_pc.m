function [centroids] = clustering_pc(points, NC)
    close all;
    centroids = Forgy(points, NC);
    modified = true;
    [n, m] = size(points);
    while modified
        clusters = cell(NC, 1);
        for i = 1 : n
            min_dist = inf;
            min_j = -1;
            for j = 1 : NC
                d = sqrt(get_dist_squared(points(i, :), centroids(j, :)));
                if d < min_dist
                    min_dist = d;
                    min_j = j;
                end
            end
            clusters{min_j} = [clusters{min_j} [i]];
        end
        
        modified = false;
        for i = 1 : NC
            new_center = zeros(1, m);
            v = clusters{i, 1};
            len = size(v, 2);
            if len == 0
                continue;
            end
            for j = 1 : len
                new_center = new_center + points(v(j), :);
            end
            new_center = new_center / len;
            if centroids(i, :) ~= new_center
                modified = true;
            end
            centroids(i, :) = new_center;
        end
    end
    if draw == true
        figure(1);
        scatter(points(:, 1), points(:, 2), 'filled');
        hold on;
        scatter(centroids(:, 1), centroids(:, 2), 'd')
        colors = 'rgbyvpok';
        for i = 1 : n
            dmin = inf;
            minp = -1;
            for j = 1 : NC
                d = sqrt(get_dist_squared(points(i, :), centroids(j, :)));
                if d < dmin
                    dmin = d;
                    minp = j;
                end
            end
            plot([points(i, 1) centroids(minp, 1)], [points(i, 2) centroids(minp, 2)], ['-' colors(minp)]);
        end
    end
end

function [centroids] = Forgy(points, NC)
    [n, m] = size(points);
    centroids = zeros(NC, m);
    clusters = cell(NC, 1);
    for i = 1 : n
        clusters{mod(i, NC) + 1} = [clusters{mod(i, NC) + 1} [i]];
    end
    for i = 1 : NC
        new_center = zeros(1, m);
        v = clusters{i, 1};
        len = size(v, 2);
        if len == 0
            continue;
        end
        for j = 1 : len
            new_center = new_center + points(v(j), :);
        end
        new_center = new_center / len;
        centroids(i, :) = new_center;
    end        
end

function [centroids] = Kmeans_pp(points, NC)
    [n, m] = size(points);
    centroids = zeros(NC, m);
    p = randi(n);
    centroids(1, :) = points(p, :);
    points(p, :) = [];
    probabilities = zeros(n, 1);
    n = n - 1;
    
    for i = 2 : NC
        p_sum = 0;
        for j = 1 : n
            d = get_dist_squared(points(j, :), centroids(i - 1, :));
            probabilities(j) = d;
            p_sum = p_sum + probabilities(j);
        end
        p = rand() * p_sum;
        
        p_sum = 0;
        for j = 1 : n
            p_sum = p_sum + probabilities(j);
            if p < p_sum
                break;
            end
        end
        
        centroids(i, :) = points(j, :);
        points(j, :) = [];
        n = n - 1;
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
