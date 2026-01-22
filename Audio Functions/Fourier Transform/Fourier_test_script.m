x = [1 2 3 4 5];
figure;
%Time Domain Input Signal
subplot(3,1,1);
n = 0:length(x)-1;
plot(n,x);
title('Input Signal x[n]');
xlabel('index');
ylabel('Amplitude');
grid on;

%Magnitude Spectrum
subplot(3,1,2);
N = 5;
X = DFT(x,N);
k = 0:N-1;
plot(k,abs(X));
title('Magnitude Spectrum |X[k]|');
xlabel('Frequency Bin k');
ylabel('|X(k)|');

%Phase Spectrum
subplot(3,1,3);
plot(k,angle(X));
title('Phase Spectrum');
xlabel('Frequency Bin k');
ylabel('Radians');

%DFT vs fft
X_fft = fft(x,N);

figure;
subplot(2,1,1);
plot(k,abs(X_fft));
title('fft');

subplot(2,1,2);
plot(k,abs(X));
title('DFT');


x_rec = IDFT(X,N);


n = 0:N-1;

figure;
stem(n,x,"filled");
hold on;
stem(n,x_rec,'r');
legend('Original x[n]', 'Reconstructed x[n]');
title('IDFT Reconstruction');

%The IDFT rebuilds the signal by summing the weighted complex sinusoids 
%Magnitude controls strength
%Phase controls alignment