function [x,A_hat,sq_error,CRLB] = CRLB(N,var)
% x(n) = A + w(n)
% n = 0...N-1;

%N = # samples
%var = variance
%std = sqrt(var);
A = 1;
w = sqrt(var) * randn(N,1); %random white gaussian noise
x = A + w;

A_hat = mean(x); %estimate of A

sq_error = (A_hat-A)^2;

CRLB = var/N; %Cramer Rao Lower Bound

end