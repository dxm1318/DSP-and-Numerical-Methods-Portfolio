
function [S_dB, freq_bins, time_bins] = buffer_spec_analysis(signal,fs,window_size,overlap)
%Inputs:
    %signal = input signal
    %fs = sampling rate
    %window_size = size of buffer
    %overlap = overlap btwn windows (samples)
%Outputs:
    %S = spectrogram
    %freq_bins = frequency bins of spectrogram
    %time_bins = time bins of the spectrogram

    
signal = signal(:); %ensure column
N = window_size;
if overlap >= N
    error('Overlap must be less than window size.');
end


window = hamming(N,'periodic'); % hamming window for better frequency resolution
nfft = 2^nextpow2(N);

[S,freq_bins,time_bins] = spectrogram(signal, window, overlap,nfft, fs);

%convert to magnitude dB spectrogram
S_dB = 20*log10(abs(S));

end
