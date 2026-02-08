fs = 48000; %sample rate
dur = 2; %duration of signal
t = 0:1/fs:dur-1/fs; %time vector

x = sin(2*pi*440*t); %input sinusoid
h = cos(2*pi*220*t); %2nd input

tic
TD_Conv = Time_Domain_Conv(x,h); %Time Domain Convolution
toc

tic
FD_Conv = Freq_Domain_Conv(x,h); %Frequency Domain Convolution
toc

MATLAB_Conv = conv(x,h); %Built-in MATLAB Convolution



figure;
plot(MATLAB_Conv);
title('Built-in MATLAB Convolution');

diff_TD = max(abs(MATLAB_Conv(:) - TD_Conv(:)));
diff_FD = max(abs(MATLAB_Conv(:) - FD_Conv(:)));

fprintf('Max difference (Time Domain vs MATLAB): %e\n', diff_TD);
fprintf('Max difference (Freq Domain vs MATLAB): %e\n', diff_FD);


%test Cross Correlation

a = [1 2 4 5 0 3];
b = [4 0 3 2 4 1 5];

CC = cross_corr(a,b);
CC_MATLAB = cross_corr(a,b);

figure;
subplot(2,1,1);
plot(CC);
title('Cross Correlation');
subplot(2,1,2);
plot(CC_MATLAB);
title('MATLAB xcorr');

diff_CC = max(abs(CC_MATLAB(:)-CC(:)));
fprintf('Max Difference Cross_Corr vs xcorr: %e\n',diff_CC);