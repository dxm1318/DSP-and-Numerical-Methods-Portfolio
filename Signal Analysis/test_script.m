%% Signal Generation

fs = 48000;
duration = 3;
t = 0:1/fs:duration - 1/fs;
%Test signal 1: Pure Tone (A - 440Hz)
f1 = 440; %440hz
pure_sine = 0.5 * sin(2*pi*f1*t); %pure sine wave
%Test signal 2: Sine wave + noise
f2 = 200; %frequency of 2nd wave
noisy_sine = 0.5*sin(2*pi*f2*t) + 0.1 * randn(size(t));

%% Loudness Analysis and Spectral Analysis


test_signals = {pure_sine,noisy_sine};
test_names = {'Pure Sine', ' Noisy Sine'};

for i = 1:length(test_signals)
    signal = test_signals{i};
    [spec_data, freq_bins, time_bins] = buffer_spec_analysis(signal,fs,4096,1024);
    %fs = 48000
    %window_size = 1024
    %overlap = 512
    
    figure;
    [rms_vector, t] = loudness_analysis(signal,48000,1024,512);
    subplot(2,1,1);
    plot(t,rms_vector);
    title("Time vs Loudness - " + test_names{i});
    xlabel('Time (s)');
    ylabel('Loudness (dB)');
    

   
    spectral_data = sc_analysis(signal,fs);
    subplot(2,1,2);
    imagesc(time_bins,freq_bins,20*log10(abs(spec_data)));
    title("time vs spectrum - " + test_names{i});
    xlabel('Time (s)');
    ylabel('magnitude');
end

%% Analyze a white noise file

% Create white noise wav file
fs_wn = 48000;
dur = 5;
t_wn = 0:1/fs_wn:dur-1/fs_wn;
white_noise = randn(size(t_wn));
filename = 'white_noise.wav';
audiowrite(filename, white_noise, fs_wn);

% Read wav file
[y_wn, fs_wn] = audioread(filename);

% Time-varying loudness
[rms_wn, t_rms] = loudness_analysis(y_wn, fs_wn, 1024, 512);

figure;
subplot(2,1,1);
plot(t_rms, rms_wn);
xlabel('Time (s)');
ylabel('Loudness (dB)');
title('Loudness - White Noise');

% Spectrogram
[S_wn, f_wn, t_spec] = buffer_spec_analysis(y_wn, fs_wn, 1024, 512);

subplot(2,1,2);
imagesc(t_spec, f_wn, S_wn);
axis xy;
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('Spectrogram - White Noise');
colorbar;
