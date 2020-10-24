function [X, y] = preprocess(path_to_dataset, histogram, count_bins)
    cats = get_files_names([path_to_dataset 'cats/'], '*.jpg');
    n_cats = size(cats, 1);
    
    not_cats = get_files_names([path_to_dataset 'not_cats/'], '*.jpg');
    n_not_cats = size(not_cats, 1);
    
    n = n_cats + n_not_cats;
    X = zeros(n, count_bins * 3);
    
    cats = [char(ones(n_cats, 1) * [path_to_dataset 'cats/']) cats];
    not_cats = [char(ones(n_not_cats, 1) * [path_to_dataset 'not_cats/']) not_cats];
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
    
    y = [ones(n_cats, 1); -ones(n_not_cats, 1)];
end

function [files_names] = get_files_names(path, format)
    files = dir([path format]);
    n = size(files, 1);
    for i = 1 : n
        m = length(files(i).name);
        files_names(i, 1 : m) = files(i).name;
    end
end