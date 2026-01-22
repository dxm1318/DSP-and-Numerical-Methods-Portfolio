function y = circular_corr(x,h) %x,h are arrays
    
    
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
             val = val + x(k) * h(mod(n+k-2,N)+ 1);
         end
         y(n) = val;
     end
  
   idx = 0:N-1;
   
   figure;
   stem(idx,real(y), 'filled');
   hold on;
   [peakVal, peakIdx] = max(abs(y));

   stem(idx(peakIdx), real(y(peakIdx)),'r','filled');
   title('Circular Corr with Peak Analysis');
   xlabel('Shift n');
   ylabel('Correlation Amplitude');

   fprintf('Maximum Correlation at shift idx = %d, value = %.4f\idx', idx(peakIdx), y(peakIdx));

end
