fs = 48000;
fc = 450;
t = 0:1/fs:1;
gain = 2;
type = 'LPF';

%create biquad filter
x = biquad(fc,gain,type,fs);

%calculate coeff of biquad filter
x = computeCoeff(x);

%create sin wav
f = 440; %frequency of sine wave
signal = sin(2*pi*f*t);

%apply filter function to sine wave
filtered_sig= filter_sig(x,signal);

%plot original signal
figure;
subplot(2,1,1);
plot(t,signal);
title('Original Signal');
xlabel('Sample Idx');
ylabel('Amplitude');
subplot(2,1,2);
plot(t,filtered_sig);
title('Filtered Signal');
xlabel('Sample Idx');
ylabel('Amplitude');