%cross correlation function
%cross correlation = convolution with reversed h


function y = cross_corr(x,h1)
    H = length(h1);
    N = length(x) + H - 1; %length cross correlation calculated the same eay as convolution
    
    y = zeros(1,N); %initialize output
    h = zeros(1,H);

    for z= 1:H
        h(z) = h1(end+1-z);
    end

    for n = 0:N-1
        for k = 0:n
            if k < length(x) && (n-k) < length(h)
            y(n+1) = y(n+1) + x(k+1)*h(n-k+1);   
            end
        end
    end
end