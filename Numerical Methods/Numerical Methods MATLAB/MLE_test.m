%% test MLE()
N = 200;
A = 0.5;
var = 0.2;
phi = pi;
f0 = 0.25;

[f0_ML,A_ML,phi_ML,x_ML] = MLE(N,A,var,phi,f0);