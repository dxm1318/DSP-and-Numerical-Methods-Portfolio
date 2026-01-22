function X = DFT(x,N)
    %x = input signal
    %N = # of analysis points
    
    %ensure a row vector
    x = x(:).';
    x = [x zeros(1,N - length(x))]; %padding if needed
    X = zeros(1,N);

    for k = 0:N-1
        for n = 0:N-1
            X(k+1) = X(k+1) + x(n+1) * exp(-1i*2*pi*k*n/N);
        end
    end
end
