% This script generates graphs for the empirical order of accuracy of
% derivative quantities in 3D when computed OVER THE ENTIRE 3D GRID, using
% the synthetic field. It can compute the partial derivatives or the
% vorticity of the field globally and determine its mean percentage of
% absolute error.
%
% Derek Li, July 2021


% Desired order of accuracy.
err_order = 7;
% Order of differentiation.
diff_order = 1;

steps = 0.05: 0.05: 0.7;
steps_count = size(steps, 2);

% Mean magnitude of error.
err = zeros(1, steps_count);

for i = 1: steps_count
    % Set step size and accuracy order.
    h = steps(i);
    vf = periodicField(repmat(h, 3, 1), 1);
    vf.solver.diff.err_order = err_order;
    
    % Compute vorticity.
    % Theoretical.
    Vort = pField_vort(repmat(h, 3, 1));
    mean_vort = mean(sqrt(sum(Vort.^2, 4)), 'all');
    % Approximated.
    vf.vort_e = vf.vorticity(0);
    
%     % Compute partial derivative.
%     xdim = 3;
%     udim = 2;
%     derv = vf.diff(vf.U_e(:,:,:,udim), xdim, 1);

%     % Theoretical gradient.
%     grad = pField_grad(repmat(h, 3, 1));
%     mean_norm = mean(sqrt(sum(grad.^2, [4 5])), 'all');
%     theo = grad(:,:,:,udim,xdim);
%     mean_mag = mean(abs(theo), 'all');
    
    % Mean absolute error.
    err(i) = mean(sqrt(sum(abs(vf.vort_e - Vort).^2, 4)), 'all');
%     err(i) = mean(abs(derv - theo), 'all') / mean_mag;
%     err(i) = mean(sqrt(sum(abs(jacob - grad).^2, [4 5])), 'all') / mean_norm;
end

% Log error plot for the order of accuracy.
figure;
logsteps = log(steps);
logerr = log(err);
scatter(logsteps, logerr, 'filled', 'r')
hold on
% Empirical order of accuracy.
pvec = polyfit(logsteps, logerr, 1);
polyplot(pvec, logsteps, 'r');

xlabel('$\ln h$')
ylabel('$\ln \delta(\nabla\times \vec{u})$')
% ylabel(strcat('$\ln', ' \delta \frac{\partial u_', vf.dim_str(udim), ...
%     '}{\partial', {' '}, vf.dim_str(xdim), '}$'))
title(strcat('empirical error order = ', {' '}, string(pvec(1))))