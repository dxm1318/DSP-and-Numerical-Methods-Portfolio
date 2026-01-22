function y = Freq_Domain_Conv(x,h)
    
    %ensure x and h are column vectors
    x = x(:);
    h = h(:);
    
    %length of convolution
    N = length(x) + length(h) - 1;

    %FFTs --> convert to frequency domain
    X = fft(x,N);
    H = fft(h,N);

    %Convolution --> frequency domain convolution
    Y = X.*H;
    
    %back to time domain via IFFT
    y = real(ifft(Y,N));

    figure;
    subplot(2,1,1);
    plot(x);
    title('Input Signal');
    subplot(2,1,2);
    plot(h);
    title('IR');
    
    figure;
    subplot(2,1,1);
    plot(abs(Y));
    title('Output Magnitude Spectrum');
    subplot(2,1,2);
    plot(y)
    title('Output Time Domain');

end



%This function does the following:
    %1) takes 2 input signals
    %2) calculates the expected length of the convolution
    %3) uses fft and transforms signals into freq domain
        %inputs = signal, number of analysis pts = length of conv
    %4) performs element wise mult.
        %** element-wise mult. in freq domain = convolution
            %in the sample domain

    %5) uses ifft() to transform result back into the sample domain