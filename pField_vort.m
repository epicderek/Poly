function Vort = pField_vort(sps)

[x, y, z] = meshgrid(0:sps(1):2*pi, 0:sps(2):2*pi, 0:sps(3):2*pi);

Vort = zeros([size(x) 3]);

xy = x.*y;

% Subresults are computed repetitively, so inefficient.
Vort(:,:,:,1) = x.*(cos(xy).*exp(sin(xy)) + cos(z).*sin(x.*sin(z)));
Vort(:,:,:,2) = -y.*(sin(z).*cos(y.*cos(z)) + cos(xy).*exp(sin(xy)));
Vort(:,:,:,3) = -sin(z).*sin(x.*sin(z)) - cos(z).*cos(y.*cos(z));
