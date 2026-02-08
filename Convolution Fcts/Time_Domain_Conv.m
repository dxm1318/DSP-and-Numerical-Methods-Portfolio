function y = Time_Domain_Conv(x,h)
    
    %ensure column vectors
    x = x(:);
    h = h(:);

    Nx = length(x);
    Nh = length(h);

    N = Nx + Nh - 1;
    y = zeros(N,1);
    
    
    
    for n = 1:N
        k_min = max(1,n-Nh+1);
        k_max = min(n,Nx);
        for k = k_min:k_max
            y(n) = y(n) + x(k) * h(n-k+1);
        end
    end
    
    %Time Indices
    nx = 0:length(x)-1;
    nh = 0:length(h)-1;
    ny = 0:length(y)-1;

    figure;
    subplot(3,1,1);
    plot(nx,x);
    title('Input Signal');
    xlabel('n');
    ylabel('Amplitude');

    subplot(3,1,2);
    plot(nh,h);
    title('Impulse Response');
    xlabel('n');
    ylabel('Amplitude');

    subplot(3,1,3);
    plot(ny,y);
    title('Convolved Signal');
    xlabel('n');
    ylabel('Amplitude');
   
end