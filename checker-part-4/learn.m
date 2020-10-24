function [w] = learn(X, y, lr, epochs)
    [n, m] = size(X);
    w = randi([-100, +100], m + 1, 1);
    w = w ./ 1000;
    batch_size = 64;
    X = [X ones(size(X, 1), 1)];
    X = scale_batch(X);
    X2 = zeros(m, 1);
    for epoch = 1 : epochs
        v = randi([1 : n], 1, batch_size);
        X_batch = X(v, :);
        y_batch = y(v, 1);
        for i = 1 : m
            X2 = (X_batch * w - y_batch) .* X_batch(:, i);
            sum_batch = sum(X2);
            w(i) = w(i) - lr / n * sum_batch;
        end
    end      
end

function [X] = scale_batch(X)
    n = size(X, 2);
    for i = 1 : n - 1
        col = X(:, i);
        X(:, i) = (col - mean(col)) / std(col);
    end
end