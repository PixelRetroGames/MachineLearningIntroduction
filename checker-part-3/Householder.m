function [Q, R] = Householder(A)
    [n, m] = size(A);
    Q = eye(n);
    for i = 1 : min(n - 1, m) 
        sigma_i = sign(A(i, i)) * norm(A(i : n, i), 2);
        v = zeros(n, 1);
        v(i) = A(i, i) + sigma_i; 
        v((i + 1) : n) = A((i + 1) : n, i);
        H_i = eye(n) - 2 * (v * v') / (v' * v);
        Q = H_i * Q;
        A = H_i * A;  
    end
    
    Q = Q';
    R = A;  
endfunction