%% Basic DSP
 %% Draw magnitude response of poles and zeros.

 % Zeros -> numerator -> feed-forward coeff.
 % Poles -> denominator -> feed-back coeff.

% Define Given Parameters
Rz = 0.3;   % Radius for zero
Rp = 0.7;   % Radius for pole

theta_z = 0;   % Zero angle
theta_p = 0;   % Pole angle

% Compute Zero
z = Rz * exp(1j * theta_z);

% Compute Pole
p = Rp * exp(1j * theta_p);

% Plot Pole-Zero Diagram
figure;
zplane(z, p);
grid on;
title('Pole-Zero Plot');
xlabel('Real Part');
ylabel('Imaginary Part');

% calculate coeficients
num = [1,-z];
den = [1,-p];

% Compute and Plot Magnitude Response
[H, w] = freqz(num, den, 1024); % Frequency response
figure;
plot(w/pi, 20*log10(abs(H)), 'LineWidth', 2);
grid on;
title('Magnitude Response of First-Order Filter');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');
ylim([-40, 10]);

%% Compute the coefficients for shelf filter

fs = 44100;

% low shelf
f = 100;
w = 2*pi*f/fs; 
k = db2mag(4); %+4 dB shelf gain
t = tan(w/2);

% Compute coefficients using Bennett's proportional parametric EQ formulas
% from Digital Audio Theory
b0n = t+sqrt(k);

a0 = (k*t+sqrt(k))/b0n;
a1 = (k*t-sqrt(k))/b0n;

b1 = (t-sqrt(k))/b0n;
b0 = 1;

% Analyze coefficients
[H_LS, F] = freqz([a0,a1], [b0,b1], fs, fs);

%plot magnitude response
figure;
semilogx(F, 20*log10(abs(H_LS)));
grid on;
title("Low Shelf Magnitude Response")
xlabel("Frequency");
ylabel("Amplitude")
axis([20 20000 -12 12]);

%% Draw the magnitude response with the given poles and zeros
z = [pi/4, -pi/4];   % Zero angles
p = [3*pi/4, -3*pi/4]; % Pole angles

% Radii
Rz = 0.5;
Rp = 0.25;

% Compute zeros
z1 = Rz * exp(1j * z(1));
z2 = Rz * exp(1j * z(2));

% Compute poles
p1 = Rp * exp(1j * p(1));
p2 = Rp * exp(1j * p(2));

% get coefficients from roots
% Numerator (Zeros)
num = poly([z1, z2]);

% Denominator (Poles)
den = poly([p1, p2]);

% Compute Frequency Response
[H, w] = freqz(num, den, 1024); % Compute frequency response

% Plot Magnitude Response
figure;
plot(w/pi, 20*log10(abs(H)), 'LineWidth', 2);
grid on;
title('Magnitude Response of Biquad Filter with Given Poles and Zeros');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');
ylim([-40, 10]);


%% Choose a song or a track. Insert the plots of the song and its spectrogram from MATLAB.

[audio, fs] = audioread("flute.wav");

% make audio mono
audio = mean(audio,2);

%sound(audio, fs);
t = (0:length(audio)-1)/fs; %time vector

% plot
figure;
subplot(2,1,1);
plot(t,audio);
title("Flute Audio Signal");
xlabel('Time (s)');
ylabel('Amplitude');

% spectrogram
subplot(2,1,2);
[~, f, t, p] = spectrogram(audio, 128, 120, 128, fs);
imagesc(t, f, 10*log10(abs(p)));  % Convert to dB scale
axis xy;
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('Flute Spectrogram');
colorbar;

%% Calculate Coefficients, Plot Frequency and Magnitude Response, then apply filter to a signal

% Define new poles and zeros
Rz = 0.5;   % Radius for zero
Rp = 0.9;   % Radius for pole

theta_z = pi;   % Zero angle
theta_p = pi/4;   % Pole angle

% Compute Zero
z = [Rz * exp(1j * theta_z), Rz*exp(-1i*theta_z)];

% Compute Pole
p = [Rp * exp(1j * theta_p), Rp*exp(-1i*theta_p)];

% calculate coeficients
num = poly(z);
den = poly(p);

% Compute and Plot Magnitude Response
[H, w] = freqz(num, den, 1024); % Frequency response
figure;
plot(w/pi, 20*log10(abs(H)), 'LineWidth', 2);
grid on;
title('Magnitude Response of First-Order Filter');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');
ylim([-20, 20]); % Adjust as needed

% Filter flute signal
flute_filt = filter(num, den, audio);

% plot
figure;
subplot(2,1,1);
plot(flute_filt);
title("Filtered Flute Audio Signal");
xlabel('Time (Samples)');
ylabel('Amplitude');

% spectrogram
subplot(2,1,2);
[~, f, t, p] = spectrogram(flute_filt, 128, 120, 128, fs);
imagesc(t, f, 10*log10(abs(p)));  % Convert to dB scale
axis xy;
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('Filtered Flute Spectrogram');
colorbar;

%% Time-based Convolution

% Define the two input signals
x = [5,2,1,4,3];       
h = [1,2,3,4,5];       

% Perform convolution using the conv function
y = conv(x, h);

figure;
subplot(3, 1, 1);
plot(x);
title('x(t)');
xlabel('Time (t)');
ylabel('Amplitude');
grid on;

subplot(3, 1, 2);
plot(h);
title('h(t)');
xlabel('Time (t)');
ylabel('Amplitude');
grid on;

subplot(3, 1, 3);
plot(y);
title('Convolution Output y(t) = x(t) * h(t) (Time Domain)');
xlabel('Time (t)');
ylabel('Amplitude');
grid on;

%% Frequency Based Convolution

%Define Input Signal
x = [5,2,1,4,3];
h = [1,2,3,4,5];

N = length(x) + length(h)- 1;
% 1. convert to frequency domain using fft()
X = fft(x,N);
H = fft(h,N);

% 2. Multiply in Frequency Domain
Y = X .* H;

% 3. Transform back to Time Domain
y = ifft(Y);

% Plot the input signals and the convolution output
figure;
subplot(3, 1, 1);
plot(x);
title('x(t)');
xlabel('Time (t)');
ylabel('Amplitude');
xlim([1 5])
grid on;

subplot(3, 1, 2);
plot(h);
title('h(t)');
xlabel('Time (t)');
ylabel('Amplitude');
xlim([1 5])
grid on;

subplot(3, 1, 3);
plot(y);
title('Convolution Output y(t) = x(t) * h(t) (Frequency Domain)');
xlabel('Time (t)');
ylabel('Amplitude');
xlim([1 9]);
grid on;
