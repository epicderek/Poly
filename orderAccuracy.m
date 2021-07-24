% This script is used for plotting the empirical order of accuracy both for
% the initial problem in 1D in section 2 of paper but also the variation
% along a single ray extracted from the 3D synthetic field. The function to
% be differentiated here also corresponds to that partial function.

% Analytical function whose derivative is computed numerically by finite
% differences and comapred to the known solution.
x0 = 2*pi;
y = @(x) exp(sin(x0*x));
% First, second, and third derivatives.
dy = @(x) x0*cos(x0*x).*exp(sin(x0*x));
% d2y = @(x) -sin(x).*exp(sin(x)) + cos(x).^2.*exp(sin(x));
% d3y = @(x) -cos(x).*exp(sin(x)) - sin(x).*cos(x).*exp(sin(x)) + ...
%     cos(x).^3.*exp(sin(x)) - 2*cos(x).*sin(x).*exp(sin(x));

% Degree of polynomial.
err_order = 7;
% Order of differentiation.
diff_order = 1;

% Exponential steps show curious behavior that does not converge.
% steps = exp(-10: 0.4: -1);

steps = 0.005: 0.01: 0.1;
steps_count = size(steps, 2);

err = zeros(1, steps_count);

for i = 1: steps_count
    h = steps(i);
    x = (0: h: 2*pi)';
    % Differentiation matrix.
    D = centricMatrix(size(x, 1), diff_order, err_order) / h^diff_order;
    err(i) = mean(abs(dy(x) - D * y(x)));
%     % Optional plotting of derivative for comparison.
%     figure;
%     plot(x, dy(x))
%     hold on
%     scatter(x, D * y(x))
end

% Generate log-log plot whose slope should correspond to order of accuracy.
log_steps = log(steps);
log_err = log(err);

figure;
scatter(log_steps, log_err, 'filled')
hold on
pvec = polyfit(log_steps, log_err, 1);
polyplot(pvec, log_steps, 'r');
xlabel('$\ln h$')
ylabel('$\ln \epsilon$')
title(strcat('$\ln \epsilon / \ln h$ = ', {' '}, string(pvec(1))))