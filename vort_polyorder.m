% Generate an error vs order of accuracy graph using synthetic vortex when
% computing the vorticity.
%
% Derek Li, July 2021

% Uniform spacing in x, y, z.
h = 0.2;
vf = periodicField(repmat(h, 3, 1), 1);
% Theoretical vorticity field.
Vort = pField_vort(repmat(h, 3, 1));

err_order = 1: 10;
order_count = size(err_order, 2);

err = zeros([size(vf.U_e) order_count]);

% Compute vorticity with increasing theoretical orders of accuracy.
for i = 1: order_count
    vf.solver.diff.err_order = err_order(i);
    vf.vort_e = vf.vorticity(0);
    err(:,:,:,:,i) = vf.vort_e - Vort;
end

% Sum of vorticity magnitudes.
vort_mag = squeeze(sqrt(sum(Vort.^2, 4)));

% Mean vorticity magnitude.
mean_vort = mean(vort_mag, [1 2 3]);

% Normalize error by mean vorticity magnitude.
err = err / mean_vort;

% Magnitude of error.
err_mag = squeeze(sqrt(sum(err.^2, 4)));

% % Mean percentage of error.
err_mean = squeeze(mean(sqrt(sum(err.^2, 4)), [1 2 3]));

figure;
scatter(err_order, err_mean, 'r', 'filled')

xlabel('Degree of Polynomial $n$')
ylabel('Mean Error $\delta (\nabla\times\vec{u})$')

% % Plot error.
% for i = 1: order_count
%     vf.plotVector(err(:,:,:,:,i), 0, '$\delta\vec{\omega}$')
%     vf.plotScalar(err_mag(:,:,:,i), 0, '$\delta \omega$')
%     pause
% end