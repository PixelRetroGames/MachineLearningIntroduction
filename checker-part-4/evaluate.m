function [percentage] = evaluate(path_to_testset, w, histogram, count_bins)
    cats = get_files_names([path_to_testset 'cats/'], '*.jpg');
    n_cats = size(cats, 1);
    
    not_cats = get_files_names([path_to_testset 'not_cats/'], '*.jpg');
    n_not_cats = size(not_cats, 1);
    
    percentage = 0;
    w_t = w';
    
    cats = [char(ones(n_cats, 1) * [path_to_testset 'cats/']) cats];
    not_cats = [char(ones(n_not_cats, 1) * [path_to_testset 'not_cats/']) not_cats];
    X = zeros(n_cats + n_not_cats, count_bins * 3);
    
    if histogram == 'RGB' 
        for i = 1 : n_cats
            X(i, :) = rgbHistogram(cats(i, :), count_bins);
        end
        for i = 1 : n_not_cats
            X(n_cats + i, :) = rgbHistogram(not_cats(i, :), count_bins);
        end
    else
        for i = 1 : n_cats
            X(i, :) = hsvHistogram(cats(i, :), count_bins);
        end    
        for i = 1 : n_not_cats
            X(n_cats + i, :) = hsvHistogram(not_cats(i, :), count_bins);
        end
    end
    X = [X zeros(size(X, 1), 1)];
    X = scale_batch(X);
    for i = 1 : n_cats
        if get_prediction(w_t, X(i, :)) >= 0
            percentage++;
        end
    end
    for i = 1 : n_not_cats
        if get_prediction(w_t, X(n_cats + i, :)) >= 0
            percentage++;
        end
    end
    
    percentage = percentage / (n_cats + n_not_cats)
end

function [y] = get_prediction(w_t, x)
    y = w_t * x';
end

function [X] = scale_batch(X)
    n = size(X, 2);
    for i = 1 : n - 1
        col = X(:, i);
        X(:, i) = (col - mean(col)) / std(col);
    end
end

function [files_names] = get_files_names(path, format)
    files = dir([path format]);
    n = size(files, 1);
    for i = 1 : n
        m = length(files(i).name);
        files_names(i, 1 : m) = files(i).name;
    end
end