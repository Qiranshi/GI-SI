function pinvA = pseudoInverse_SVD(A)
    % 使用SVD方法计算A的伪逆
    [U, S, V] = svd(A);
    %S_inv = inv(S);
    pinvA = V / S * U';
end