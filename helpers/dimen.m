function V = dimen(v, dims)
% Replicate vector v to have preceding dimensions as specified by dims(1) x
% dims(2) x dims(3) x length(v). Size of 'dims' is upposed to be 3.

V = NaN([dims length(v)]);

for i = 1: length(v)
    V(:,:,:,i) = repmat(v(i), dims);
end
