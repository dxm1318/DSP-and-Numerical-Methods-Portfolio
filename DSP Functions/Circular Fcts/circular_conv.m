function y = circular_conv(x,h) %x,h are arrays
    
    %Ensure Row Vectors
    x = x(:).';
    h = h(:).';

    %zero-pad to equal length
    N = max(length(x),length(h));
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
     stem(idx,x,'filled');
     hold on;
     stem(idx+N,x,'--');
     stem(idx,h,'r','filled');
     title('Input Signals Periodic');
     xlabel('n');
     ylabel('Amplitude');
     legend('x[n','x[n] repeated', 'h[n]');
end