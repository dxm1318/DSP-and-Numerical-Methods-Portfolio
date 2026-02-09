
%% spectral analysis

function [mag_dB, freq_bins] = sc_analysis(y,fs)
%y = input signal, fs = sampele rate
y = y(:);
N = length(y); 

window = hann(N,'periodic');
y = y.* window;

Y = fft(y); %perform fft
Y = Y(1:floor(N/2)+1);

freq_bins = (0:floor(N/2))* fs/N;
mag = abs(Y)/N; %mag of fft
mag(2:end-1) = 2*mag(2:end-1);

mag_dB = 20*log10(mag); %convert mag to dB
end
