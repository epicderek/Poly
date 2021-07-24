function grad = pField_grad(sps)

[x, y, z] = meshgrid(0:sps(1):2*pi, 0:sps(2):2*pi, 0:sps(3):2*pi);

grad = zeros([size(x) 3 3]);

xy = x.*y;

% Subresults are computed repetitively, so inefficient.
grad(:,:,:,1,2) = cos(z).*cos(y.*cos(z));
grad(:,:,:,1,3) = -y.*sin(z).*cos(y.*cos(z));
grad(:,:,:,2,1) = -sin(z).*sin(x.*sin(z));
grad(:,:,:,2,3) = -x.*cos(z).*sin(x.*sin(z));
grad(:,:,:,3,1) = y.*cos(xy).*exp(sin(xy));
grad(:,:,:,3,2) = x.*cos(xy).*exp(sin(xy));
