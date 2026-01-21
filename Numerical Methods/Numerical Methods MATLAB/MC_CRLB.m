%% Monte Carlo Simulation for Convergence to CRLB

num_trials = 5000;  % number of Monte Carlo trials
N = 1000;           % sample size
A = 1;              % true mean
var = 4;            % true variance
std = sqrt(var);

A_errors = zeros(num_trials,1);
B_errors = zeros(num_trials,1);

for k = 1:num_trials
    w_mc = std*randn(N,1);
    x_mc = A + w_mc;
    
    % Estimate A and B
    A_hat_mc = mean(x_mc);
    B_hat_mc = mean((x_mc - A_hat_mc).^2);
    
    % Squared errors
    A_errors(k) = (A_hat_mc - A)^2;
    B_errors(k) = (B_hat_mc - var)^2;
end

% Average squared errors over trials
A_mse = cumsum(A_errors)./(1:num_trials)'; % running average
B_mse = cumsum(B_errors)./(1:num_trials)';

% CRLBs
CRLB_A = var/N;
CRLB_B = 2*(var^2)/N;

%% Plot convergence
figure;

subplot(2,1,1);
plot(1:num_trials, A_mse, 'b', 'LineWidth', 1.5);
hold on;
yline(CRLB_A, 'r--', 'LineWidth', 2);
xlabel('Number of Monte Carlo Trials');
ylabel('MSE of \hat{A}');
title('Convergence of Squared Error of A to CRLB');
legend('Estimated MSE', 'CRLB');
grid on;

subplot(2,1,2);
plot(1:num_trials, B_mse, 'b', 'LineWidth', 1.5);
hold on;
yline(CRLB_B, 'r--', 'LineWidth', 2);
xlabel('Number of Monte Carlo Trials');
ylabel('MSE of \hat{B}');
title('Convergence of Squared Error of B to CRLB');
legend('Estimated MSE', 'CRLB');
grid on;
