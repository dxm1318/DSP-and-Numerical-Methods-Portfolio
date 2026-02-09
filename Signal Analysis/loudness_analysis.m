
function [rms_dB, time_bins] = loudness_analysis(y, fs, window_size, overlap)
% Computes time-varying RMS loudness in dB
% y          : input signal (column or row vector)
% fs         : sampling rate
% window_size: number of samples per frame
% overlap    : number of overlapping samples per frame
%
% Outputs:
% rms_dB     : vector of RMS loudness in dB per frame
% time_bins  : vector of time values for each frame (center of frame)

y = y(:); % ensure column
step = window_size - overlap;
Nframes = floor((length(y) - overlap)/step);

rms_dB = zeros(Nframes,1);
time_bins = zeros(Nframes,1);

for k = 1:Nframes
    idx_start = (k-1)*step + 1;
    idx_end = idx_start + window_size - 1;
    frame = y(idx_start:idx_end);

    rms = sqrt(mean(frame.^2));
    rms_dB(k) = 20*log10(rms + eps); % avoid -Inf for silent frames
    time_bins(k) = (idx_start + idx_end)/(2*fs); % center time of frame
end
end






