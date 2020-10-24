function [sol] = hsvHistogram(path_to_image, count_bins)
    rgb_img = imread(path_to_image);
    img = img_rgb2hsv(rgb_img);
  
    h_ch = reshape(img(:, :, 1), 1, []) ./ 1.01;
    s_ch = reshape(img(:, :, 2), 1, []) ./ 1.01;
    v_ch = reshape(img(:, :, 3), 1, []) ./ 1.01;
    
    bucket = 1 / count_bins;
    v = [0 : bucket : 1];
    
    h_bins = histc(h_ch, v);
    s_bins = histc(s_ch, v);
    v_bins = histc(v_ch, v);
    
    assert(sum(h_bins) + sum(s_bins) + sum(v_bins) == size(img, 1) * size(img, 2) * 3)
    sol = [h_bins(1 : count_bins) s_bins(1 : count_bins) v_bins(1 : count_bins)];  
    
    %fprintf(stdout, "Loaded: %s\n", path_to_image);
    %fflush(stdout);
end

function [hsv_img] = img_rgb2hsv(rgb_img)
    [n, m, k] = size(rgb_img);
    hsv_img = zeros(n, m, 3);
    
    r = reshape(rgb_img(:, :, 1), 1, []);
    g = reshape(rgb_img(:, :, 2), 1, []);
    b = reshape(rgb_img(:, :, 3), 1, []);
    [h, s, v] = pixel_rgb2hsv(r, g, b);
    
    hsv_img(:, :, 1) = reshape(h, n, m);
    hsv_img(:, :, 2) = reshape(s, n, m);
    hsv_img(:, :, 3) = reshape(v, n, m);
end

function [h, s, v] = pixel_rgb2hsv(r, g, b)
    rn = double(r) ./ 255;
    gn = double(g) ./ 255;
    bn = double(b) ./ 255;
    
    M = [rn; gn; bn];
    cmax = max(M);
    cmin = min(M);
    d = cmax - cmin;
    d_safe = d;
    d_safe(d_safe == 0) = 1;
    
    rmax = ((cmax(:) == rn(:)))';
    mod6 = double(mod((gn - bn) ./ d_safe, 6));
  
    gmax = (cmax(:) == gn(:))';
    gmax = bitand(gmax, ~rmax);
    bmax = (cmax(:) == bn(:))';
    bmax = bitand(bitand(bmax, ~gmax), ~rmax);
    
    d0 = (d(:) ~= 0)';
    h = d0 .* (rmax .* mod6 + (gmax .* bn + (bmax - gmax) .* rn - bmax .* gn) ./ d_safe + 2 * gmax + 4 * bmax) / 6;
    cmax_safe = cmax;
    cmax_safe(cmax_safe == 0) = 1;
    s = (cmax(:) ~= 0)' .* (ones(size(cmin)) - cmin ./ cmax_safe);
    v = cmax;
end