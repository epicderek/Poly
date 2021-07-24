function V = operate3Vector(V, v, op)
% Perform binary operation defined by 'op' on each 3-vector of
% the 4D matrix 'V' with the given 3-vector 'v'.

if ndims(V) ~= 4 || size(V, 4) ~= 3
    error('Proper 4D matrix expected!')
end
V(:,:,:,1) = op(V(:,:,:,1), v(1));
V(:,:,:,2) = op(V(:,:,:,2), v(2));
V(:,:,:,3) = op(V(:,:,:,3), v(3));