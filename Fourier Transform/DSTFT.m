function X = DSTFT(x,H,L)
    % x = input signal
    % H = hop size
    % L = length of signal x

    N = input('Enter a even integer: '); % N = number of analysis points

    if mod(N,2) ~=0
        disp('Please enter a even integer for N');
    end

    % X = stft of signal x
    M = floor((L-N)/H)+1; 
    K = (N/2)+1; %frequency index
    

    %window selection
    window = input('Enter hann, hamming, blackman, or kaiser: ');
    
    switch window
        case 'hann'
            w = hann(N);
        case 'hamming'
            w = hamming(N);
        case 'blackman'
            w = blackman(N);
        case 'kaiser'
            beta = input('Input beta parameter for kaiser: ');
            w = kaiser(N,beta); 
    end
    
    for m = 0:M-1
        for k = 0:K-1
            n = 0:N-1;
            X(m+1,k+1) = sum(x(n +m*H + 1).* w.' .* exp(-2*pi*1i*k*n/N));
        end
    end
end
            