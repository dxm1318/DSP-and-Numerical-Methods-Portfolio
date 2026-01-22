fs = 48000; %sample rate
dur = 2; %duration of signal
t = 0:1/fs:dur-1/fs; %time vector

x = sin(2*pi*440*t); %input sinusoid
h = [1 zeros(1,length(x)-1)]; %IR

TD_Conv = Time_Domain_Conv(x,h);

%soundsc(x,fs);
%soundsc(h,fs);
soundsc(TD_Conv,fs);