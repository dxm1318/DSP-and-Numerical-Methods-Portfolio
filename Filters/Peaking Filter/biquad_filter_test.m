fc = 400;
Q = 0.5;
gain = 12; %dB
fs = 44100;
duration = 3;
t = 0:1/fs:duration-1/fs;

%create instance of class

instance = biquad_filter(fc,Q,gain,fs);

%test frequency response
instance.plot_freq_resp();

%sine tone
f = 5000; %frequency of sine tone
sine_tone = sin(2*pi*f*t);

y = instance.peaking_filter(sine_tone);

instance.plot_sig(sine_tone);
title('Input Signal');

instance.plot_sig(y);
title('filtered signal');


%ESS
f0 = 50; %start frequency
f1 = 2500; %end frequency
t1 = 3; %duration of sweep in seconds

ESS = chirp(t,f0,t1,f1);
y_ESS = instance.peaking_filter(ESS);

instance.plot_sig(ESS);
title('ESS');

instance.plot_sig(y_ESS);
title('ESS filtered');


%wave file

[y1,fs] = audioread('flute.wav');
y1 = mean(y1,2);

y2 = instance.peaking_filter(y1);

instance.plot_sig(y1);
title('Input Audio');

instance.plot_sig(y2);
title('Filtered Audio');

