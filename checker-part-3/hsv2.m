function [sol] = hsv2(path_to_image, count_bins)
    profile on;
    rgb_img = imread(path_to_image);
    img = img_rgb2hsv(rgb_img);
    
    h_ch = reshape(img(:, :, 1), 1, []) ./ 1.01;
    s_ch = reshape(img(:, :, 2), 1, []) ./ 1.01;
    v_ch = reshape(img(:, :, 3), 1, []) ./ 1.01;
    
    bucket = double(1) / count_bins;
    v = [0 : bucket : 1];
    h_bins = histc(h_ch, v);
    s_bins = histc(s_ch, v);
    v_bins = histc(v_ch, v);
    
    assert(sum(h_bins) + sum(s_bins) + sum(v_bins) == size(img, 1) * size(img, 2) * 3)
    sol = [h_bins(1 : count_bins) s_bins(1 : count_bins) v_bins(1 : count_bins)];  
    fprintf(stdout, "Loaded: %s\n", path_to_image);
    fflush(stdout);
    profile off;
end

function [hsv_img] = img_rgb2hsv(rgb_img)
    [n, m, k] = size(rgb_img);
    hsv_img = zeros(n, m, 3);
    %[hsv_img(:, :, 1), hsv_img(:, :, 2), hsv_img(:, :, 3)] = arrayfun(@pixel_rgb2hsv, rgb_img(:, :, 1), rgb_img(:, :, 2), rgb_img(:, :, 3));    
    for i = 1 : n
        for j = 1 : m
            hsv_img(i, j, :) = pixel_rgb2hsv(rgb_img(i, j, :));
        end
    end
end

function [hsv_pixel] = pixel_rgb2hsv(rgb_pixel)
    r = rgb_pixel(1);
    g = rgb_pixel(2);
    b = rgb_pixel(3);
    rn = double(r) / 255;
    gn = double(g) / 255;
    bn = double(b) / 255;
    
    cmax = max([rn, gn, bn]);
    cmin = min([rn, gn, bn]);
    d = cmax - cmin;
    
    if d == 0
        h = 0;
    else
        if cmax == rn
            h = 60 * mod((gn - bn) / d, 6);
        elseif cmax == gn
            h = 60 * ((bn - rn) / d + 2);
        elseif cmax == bn
            h = 60 * ((rn - gn) / d + 4);
        end
    end
    h = h / 360;
    
    if cmax == 0
        s = 0;
    else 
        s = d / cmax;
    end

    v = cmax;    
    hsv_pixel = [h, s, v];
end