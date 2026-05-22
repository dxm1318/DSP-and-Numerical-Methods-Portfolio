# Numerical Methods and Estimation Theory

**Author:** Daniel Martens

## Overview

This folder contains Python and MATLAB scripts demonstrating fundamental **numerical analysis** techniques and **estimation theory** concepts. Topics include root finding, numerical integration, Monte Carlo simulation, ODE solving, and Maximum Likelihood Estimation (MLE).

---

## Python — Numerical Analysis

Scripts use Python 3.x standard libraries only (`math`, `random`, `cmath`).

| File | Method | Description |
|------|--------|-------------|
| `bisection_method.py` | Bisection method | Root finding for f(x) = 4 − x·ln(x); accepts user interval input, validates sign change |
| `muellersmethod.py` | Müller's method | Complex polynomial roots via Horner's evaluation; initializes with two Newton steps |
| `Gaussian_Adaptive.py` | Adaptive Gaussian quadrature | Integrates f(x) = x²·ln(2x+5); recursively subdivides until error < tolerance (max depth 50) |
| `Monte_Carlo.py` | Monte Carlo integration | Estimates area and integral of f(x,y) = xy over a 2D region via rejection sampling |
| `Monte_Carlo_3D.py` | 3D Monte Carlo integration | Integrates f(x,y,z) = y·x² + z·ln(y) + exp(x) over a rectangular volume; shows convergence with increasing N |
| `richardsonextrapolation.py` | Richardson extrapolation | Builds a table of derivative approximations eliminating O(h²), O(h⁴), ... error terms |
| `RK4.py` | Runge-Kutta 4th order | Solves n-dimensional first-order ODE systems with a generic `rk4_step` function |

**Usage:** Run from terminal or any Python IDE.

---

## MATLAB — Estimation Theory

| File | Description |
|------|-------------|
| `CRLB.m` | Calculates the theoretical Cramér-Rao Lower Bound and squared error for a DC signal in white Gaussian noise |
| `MC_CRLB.m` | Monte Carlo verification of CRLB over 5000 trials; plots MSE convergence to theoretical bounds for mean (A) and variance (B) |
| `MLE.m` | MLE to recover frequency, amplitude, and phase of a sinusoidal signal in noise; minimizes cost function J(f) = ‖x − H·α‖² over frequency candidates |
| `MLE_test.m` | Test script for `MLE.m` with predefined parameters |

**Usage:** Open files in MATLAB and run directly, or call from the command window.

---

## Requirements

- Python 3.x (standard library — no external packages required)
- MATLAB R2018a or later
