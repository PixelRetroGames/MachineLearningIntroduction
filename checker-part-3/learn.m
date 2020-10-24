function [w] = learn(X, y)
    X_tilde = [X ones(size(X, 1), 1)];
    [Q, R] = Householder(X_tilde);
    w = SST(R, Q' * y);
end
