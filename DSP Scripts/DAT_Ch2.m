%% Plotting Complex Vectors
theta = pi/6; %angle
r = 1/2;%magnitude
x = r*exp(1i*theta); %complex vector --> exp = e
N = 10;

polarplot(theta*ones(N,1),linspace(0,r,N));
figure;
compass(x); %compass function plots a vector on the complex plane

%extract Re and Im elements from polar form

%Re{x}
a = r*cos(theta);
%Im{x}
b = r*sin(theta);
%or use native commands to get the same result
a = real(x);
b = imag(x);

%calculate magnitude and phase
mag = sqrt(a^2 + b^2);
Ph = atan(b/a);
%use native commands to calculate magnitude + phase
mag = abs(x);
Ph = angle(x);

%% Programming Example: Rotating a Complex Phasor

%create a complex phasor by rotating a vector
    %increment the angle of a vector 'v' by using time variable 't'
    %magnitude = 0.5; frequency = 1hz
    %use a for loop to iterate from t = 0-0.5s using steps of 1/12
    %plot vector at each time point

a = 0.5; %magnitude
t_step = 1/12; %increment size
t_max = 0.5; 
f = 1; %frequency
vv = []; %holds array of vectors

%loop through time
for t = 0:t_step:t_max
    ang = 2*pi*f*t;
    v = a*exp(1i*ang); %vector
    vv = [vv v]; %add vector to vector array
    gs = 1-t/t_max; %RGB triplet value --> updates the color for each plotted vector
    polarplot(v,marker = 'o', MarkerSize= 20,MarkerFaceColor= [gs gs gs], MarkerEdgeColor='k');
    hold on;
end
hold off;
pax = gca;
pax.ThetaAxisUnits = 'radians';
%% Programming Example: Beat Frequencies

t = 0:0.0001:1; %time vector
x1 = cos(2*pi*100*t); %tone 1 (100hz)
x2 = cos(2*pi*104*t); %tone 2 (104hz)
plot(t,x1+x2); %combination

%plotting a tone at 102 hz with a beat frequency of 2 hz 

beat = 2.* cos(2*pi*2*t);
x3 = cos(2*pi*102*t).* beat;

hold on;
plot(t,x3);
plot(t, beat);
hold off;
%% Challenges

%1a
x1 = -2+3i;
x2 = 0.5-1i;
y1 = x1 + x2;
%1b
x2c = conj(x2);
y2 = x1/x2c;


x3 = 0.75*exp(1j*pi/2);
%2a
a2 = log(x3); %log() computes the natural log --> ln()
%%log2() = log base 2; log10() = log base 10
%2b
b2 = x3*conj(x3);
%2c
c2 = real(x3)+imag(x3); %extract real and imaginary portions using built-in MATLAB functions
%% Project 2

%amplitude modulation
fs = 48000;
duration = 3;
t = 0:1/fs:duration-1/fs;
ac1 = 0.4; %amp carrier wave
am1 = 0.3; %amp mod wave
fc1 = 700; %freq carrier wave
fm1 = 300; %freq mod wave

AM1 = ac1*(1+(am1*cos(2*pi*fm1*t))).*cos(2*pi*fc1*t);

subplot(3,1,1);
plot(AM1);
title("AM 300 hz Modulator");
%soundsc(AM1,fs);
audiowrite("amplitude_modulation.wav",AM1,fs);

ac2 = 0.4;
am2 = 0.3;
fc2 = 700;
fm2 = 50;

AM2 = ac2*(1+(am2*cos(2*pi*fm2*t))) .* cos(2*pi*fc2*t);

subplot(3,1,2);
plot(AM2);
title("AM 50 Hz Modulator");
%soundsc(AM2,fs);
audiowrite("amplitude_modulation2.wav",AM2,fs);

[y,fs1] = audioread("flute copy.wav");
info = audioinfo("flute copy.wav");
y_mono = mean(y,2);
y_mono = y_mono';

dur = info.Duration;
t1 = 0:1/fs1:dur-1/fs1;

LFO = sin(2*pi*20*t1);

tremolo = y_mono .* LFO;
subplot(3,1,3);
plot(tremolo);
title('Tremolo');
%soundsc(tremolo,fs1);

%frequency modulation

%use same fs,duration,t as amplitude modulation

ac3 = 0.3;
am3 = 0.2;
fc3 = 700;
fm3 = 300;

FM1 = ac3*cos(2*pi*fc3*t+am3*cos(2*pi*fm3*t));

figure;
subplot(2,1,1);
plot(FM1);
title("FM 300 hz Modulator");
%soundsc(FM1,fs);
audiowrite("Frequency_Modulation.wav",FM1,fs);

ac4 = 0.3;
am4 = 0.2;
fc4 = 700;
fm4 = 50;

FM2 = ac4*cos(2*pi*fc4*t+am4*cos(2*pi*fm4*t));

subplot(2,1,2);
plot(FM2);
title("FM 50 hz modulator");
%soundsc(FM2,fs);
audiowrite("Frequency_Modulation2.wav",FM2,fs);


