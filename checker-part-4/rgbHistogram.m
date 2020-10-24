function [sol] = rgbHistogram(path_to_image, count_bins)
    img = imread(path_to_image);
    r_ch = reshape(img(:, :, 1) + 1, 1, []);
    g_ch = reshape(img(:, :, 2) + 1, 1, []);
    b_ch = reshape(img(:, :, 3) + 1, 1, []);
    
    bucket = 256 / count_bins;
    v = [0 : bucket : 256] + 1;
    r_bins = histc(r_ch, v);
    g_bins = histc(g_ch, v);
    b_bins = histc(b_ch, v);
    
    assert(sum(r_bins) + sum(g_bins) + sum(b_bins) == size(img, 1) * size(img, 2) * 3)
    sol = [r_bins(1 : count_bins) g_bins(1 : count_bins) b_bins(1 : count_bins)];  
end