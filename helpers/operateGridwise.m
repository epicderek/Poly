function V = operateGridwise(V, R, op)
% Perform binary operation defined by 'op' on each 3-vector of
% the 4D matrix 'V' with the given 3-vector 'v'.

if ndims(V) ~= 4 || size(V, 4) ~= 3
    error('Proper 4D matrix expected!')
end
V(:,:,:,1) = op(V(:,:,:,1), R);
V(:,:,:,2) = op(V(:,:,:,2), R);
V(:,:,:,3) = op(V(:,:,:,3), R);