%compare linear and circular convolution
x = [1 3 5 7];
h = [2 4 6 8];

y_lin = conv(x,h); %linear convolution
y_circ = circular_conv(x,h); %circular convolution

figure;
subplot(2,1,1);
stem(0:length(y_lin)-1, y_lin, 'filled');
title('Linear Convolution');
xlabel('n');
ylabel('Amplitude');

subplot(2,1,2);
stem(0:length(y_circ)-1,y_circ,'filled');
title('Circular Convolution');
xlabel('n');
ylabel('Amplitude');


%compare circular correlation to cross correlation

y_corr = circular_corr(x,h); %circular correlation
y_xcorr = xcorr(x,h); %linear cross correlation

figure;
subplot(2,1,1);
stem(0:length(y_corr)-1, y_corr, 'filled');
title('Circular Correlation');
xlabel('n');
ylabel('Amplitude');

subplot(2,1,2);
stem(0:length(y_xcorr)-1,y_xcorr,'filled');
title('Cross Correlation');
xlabel('n');
ylabel('Amplitude');
