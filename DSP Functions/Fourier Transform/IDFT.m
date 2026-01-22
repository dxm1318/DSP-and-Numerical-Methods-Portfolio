function x = IDFT(X,N)
    %X = fft signal
    %N = # of analysis points
    W = exp(1i*2*pi/N); %twiddle factor
    x = zeros(1,N);
    for n = 0:N-1
        x(n+1) = 0;
        for k = 0:N-1
            x(n+1) = (x(n+1) + X(k+1)*W^(n*k));
        end
    end
    x = real(x/N);
end