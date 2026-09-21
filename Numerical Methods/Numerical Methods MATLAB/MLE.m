function [f0_ML,A_ML,phi_ML,x_ML] = MLE(N,A,var,phi,f0)
 
%Maximum Likelihood Estimate

  %inputs: 
  %N = record length
  %A = Amplitude [-1,1]
  %phi = phase [0,2*pi]
  %var = variance/noise power
  %f0 = freq [0,1]

  %outputs:
  %f0_ML = MLE f0
  %A_ML = MLE A
  %phi_ML = MLE phi
  %x_ML = MLE for reconstructed signal

n = (0:N-1)';

%generate data
w = sqrt(var)*randn(N,1); %random Gaussian Noise
x = A*cos(2*pi*f0*n+phi) + w;

%frequency grid (coarse search)

f_test = linspace(0,1,N);
J = zeros(size(f_test));

for i = 1:length(f_test)
    J(i) = ml_cost(f_test(i),n,x);
end

%ML Frequency
% The grid only locates the minimum to within one step (1/(N-1)), which is
% far coarser than the accuracy of the estimate, and the resulting frequency
% error grows into a large phase error over the record. Refine the best grid
% point with a bounded 1-D search over the two grid cells around it.
[~,idx] = min(J);
step = f_test(2) - f_test(1);
lo = max(f_test(idx) - step, 0);
hi = min(f_test(idx) + step, 1);
f0_ML = fminbnd(@(f) ml_cost(f,n,x), lo, hi, optimset('TolX',1e-9));

%ML Amplitude and Phase
H_ML = [cos(2*pi*f0_ML*n) sin(2*pi*f0_ML*n)];
alpha_ML = H_ML\x;

% A*cos(2*pi*f*n + phi) = A*cos(phi)*cos(2*pi*f*n) - A*sin(phi)*sin(2*pi*f*n),
% so alpha = [A*cos(phi); -A*sin(phi)] and the phase is atan2(-alpha(2), alpha(1))
A_ML = norm(alpha_ML);
phi_ML = mod(atan2(-alpha_ML(2),alpha_ML(1)),2*pi);

%ML Signal (noise-free)
x_ML = A_ML*cos(2*pi*f0_ML*n + phi_ML);


%plots

figure;
plot(f_test,J,'LineWidth',1.5);
hold on;
xline(f0,'--k', 'True f_0');
xlabel('frequency');
ylabel('J(f)');
title('ML Cost Function vs Frequency');

Ns = round(4/f0);
idx = 1:Ns;

figure;
plot(n(idx), x(idx), '-o', 'Color', 'k');
hold on;
plot(n(idx), A*cos(2*pi*f0*n(idx)+phi), '--r', LineWidth=1.2);
plot(n(idx), x_ML(idx), LineWidth = 1.5);
xlabel('Sample Index n');
ylabel('Amplitude');
legend('Noisy Signal', 'True Signal', 'ML Estimate');
title('Time Domain ML Reconstruction');

end

function Jf = ml_cost(f,n,x)
%least-squares cost J(f) = ||x - H*alpha||^2 for a sinusoid of frequency f
H = [cos(2*pi*f*n) sin(2*pi*f*n)];
Jf = norm(x - H*(H\x))^2;
end