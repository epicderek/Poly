function pvf = periodicField(sps, minimal)

if ~exist('minimal', 'var')
    minimal = 0;
end

[x, y, z] = meshgrid(0:sps(1):2*pi, 0:sps(2):2*pi, 0:sps(3):2*pi);

X = zeros([size(x) 3]);
X(:,:,:,1) = x;
X(:,:,:,2) = y;
X(:,:,:,3) = z;

U = zeros(size(X));
U(:,:,:,1) = sin(y.*cos(z));
U(:,:,:,2) = cos(x.*sin(z));
U(:,:,:,3) = exp(sin(x.*y));

pvf = VelocityField(X, U, minimal);