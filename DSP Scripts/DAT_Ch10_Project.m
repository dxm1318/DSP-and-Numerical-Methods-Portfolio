%% Ch 10 Project from Digital Audio Theory
%% Part 1

fs = 48000;
fBW = 1001;
B = 2*pi*fBW/fs; %normalized bandwidth -->10.11
A = 1-B/2; %Pole radius --> 10.10

f = 100;
wx = acos((2*A/(1+A^2))*cos(2*pi*f/fs)); %10.12
a0 = (1-A^2)*sin(wx); %10.13
b1 = -(2*A*cos(wx));
b2 = A^2;

%difference equation
%y[n] = a0*x[n] - b1*y[n-1] - b2*y[n-2];

%transfer function
%H = a0/(1+b1*exp(-1i*2*pi*f/fs)+b2*exp(-2i*2*pi*f/fs));

a = a0;
b = [1 b1 b2];

[x1,fs] = audioread('flute.wav');
x1f = filter(a,b,x1);
soundsc(x1f,fs);

poles = roots([1 -b1 -b2]);
zeros = roots(a);


[H1,F] = freqz(a,b,fs,fs);
%plot magnitude response with logarithmic x axis (freq)
figure;
semilogx(F,20*log10(abs(H1)));
title('Magnitude Response');
xlabel('freq (hz)');
ylabel('Magnitude (dB)');
%plot phase response
figure;
ang = angle(H1);
semilogx(F,ang);
title('Phase Response');
xlabel('Freq (hz)');
ylabel('Phase (rad)');

%% Part 2
fs = 48000;
fBW = 1000;
f0 = 2000; %desired pole frequency
B = 2*pi*fBW/fs;
A = 1-B/2;
%How do I apply gain to resonant filter coefficients?
%set the desired freq to boost near the pole

wfx = acos((2*A/(1+A^2))*cos(2*pi*f0/fs));
a0 = (1-A^2)*sin(wfx);
b1 = -2*A*cos(wfx);
b2 = A^2;

num = a0;
den = [1 b1 b2];

[x,fs] = audioread('test_beat.wav');

y1 = filter(num,den,x);
y2 = filtfilt(num,den,x);

%soundsc(x,fs); % original
%soundsc(y1,fs); % use filter()
%soundsc(y2,fs); % use filtfilt()






