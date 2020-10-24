function [percentage] = evaluate(path_to_testset, w, histogram, count_bins)
    cats = get_files_names([path_to_testset 'cats/'], '*.jpg');
    n_cats = size(cats, 1);
    
    not_cats = get_files_names([path_to_testset 'not_cats/'], '*.jpg');
    n_not_cats = size(not_cats, 1);
    
    percentage = 0;
    w_t = w';
    
    cats = [char(ones(n_cats, 1) * [path_to_testset 'cats/']) cats];
    not_cats = [char(ones(n_not_cats, 1) * [path_to_testset 'not_cats/']) not_cats];
    
    if histogram == 'RGB'
        for i = 1 : n_cats
            if get_prediction(w_t, rgbHistogram(cats(i, :), count_bins)) >= 0
                percentage += 1;
            end
        end    
        for i = 1 : n_not_cats
            if get_prediction(w_t, rgbHistogram(not_cats(i, :), count_bins)) < 0
                percentage += 1;
            end
        end
    else
        for i = 1 : n_cats
            if get_prediction(w_t, hsvHistogram(cats(i, :), count_bins)) >= 0
                percentage += 1;
            end
        end    
        for i = 1 : n_not_cats
            if get_prediction(w_t, hsvHistogram(not_cats(i, :), count_bins)) < 0
              percentage += 1;
            end
        end
    end
    
    percentage = double(percentage) / (n_cats + n_not_cats);
end

function [y] = get_prediction(w_t, x)
    x = [x 1];
    y = w_t * x';
end

function [files_names] = get_files_names(path, format)
    files = dir([path format]);
    n = size(files, 1);
    for i = 1 : n
        m = length(files(i).name);
        files_names(i, 1 : m) = files(i).name;
    end
end