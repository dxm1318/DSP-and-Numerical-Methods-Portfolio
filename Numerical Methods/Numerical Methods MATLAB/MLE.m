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

%frequency grid

f_test = linspace(0,1,N);
J = zeros(size(f_test));

for i = 1:length(f_test)
    f = f_test(i);
    H = [cos(2*pi*f*n) sin(2*pi*f*n)];
    alpha = H\x;
    J(i) = norm(x-H*alpha)^2;
end

%ML Frequency
[~,idx] = min(J);
f0_ML = f_test(idx);

%ML Amplitude and Phase
H_ML = [cos(2*pi*f0_ML*n) sin(2*pi*f0_ML*n)];
alpha_ML = H_ML\x;

A_ML = norm(alpha_ML);
phi_ML = mod(atan2(alpha_ML(2),alpha_ML(1)),2*pi);

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