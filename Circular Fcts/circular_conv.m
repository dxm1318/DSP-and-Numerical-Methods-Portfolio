function y = circular_conv(x,h) %x,h are arrays
    
    %Ensure Row Vectors
    x = x(:).';
    h = h(:).';

    %zero-pad to equal length
    N = length(x) + length(h) - 1;
    x = [x zeros(1,N-length(x))];
    h = [h zeros(1,N-length(h))];
    
    y = zeros(1,N);
     for n = 1:N
         val = 0;
         for k = 1:N
             val = val + x(k) * h(mod(n-k,N)+ 1);
         end
         y(n) = val;
     end

  
     idx = 0:N-1;
     figure;
     stem(idx,x,'filled','DisplayName','x[n]');
     hold on;
     stem(idx,h,'m','filled','DisplayName','h[n]');
     title('Inputs');
     hold off;
     figure;
     stem(idx,y,'r','filled');
     title('Circular Conv Output');
     xlabel('n');
     ylabel('Amplitude');
end