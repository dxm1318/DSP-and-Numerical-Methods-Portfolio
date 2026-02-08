# Circular Convolution and Correlation (MATLAB)

This repository contains MATLAB implementations of **circular convolution** and **circular correlation**, along with a test script that compares the custom functions against MATLAB’s built-in functions.

The code is intended for educational and signal-processing demonstration purposes and includes visualizations for intuitive understanding.

---

## Files

### `circular_conv.m`
Implements **circular convolution** of two discrete-time signals using the definition-based summation formula.

**Key features:**
- Accepts two input sequences `x` and `h`
- Converts inputs to row vectors
- Zero-pads both signals to length: `N = length(x) + length(h) - 1`
- Computes circular convolution manually using nested loops and modular indexing
- Plots:
  - Input signals `x[n]` and `h[n]`
  - Circular convolution output

**Function signature:**
matlab call:
```y = circular_conv(x, h)```

### circular_corr.m

Implements **circular correlation** between 2 discrete-time signals

**Key Features** 
- accepts 2 input sequences/signals `x` and `h`
- inputs are converted to row vectors
- signals are zero-padded to a common length: `N = length(x) + length(h) - 1`
- computes circular correlation using modular indexing
- maximum correlation value and corresponding shift index are identified
- the peak location is highlighted on the plot

**Function Signature**
matlab call:
```y = circular_corr(x,h)```

### circular_test_script.m

Script designed to test and compare custom implementations

**Key Features**

- Defines example signals x and h
- Compares:
  Linear Convolution (conv)
  MATLAB circular convolution (cconv)
  Custom Circular Convolution (circular_conv)
- Compares:
  Linear cross correlation (xcorr)
  Custom Circular Correlation (circular_corr)
-produces figures for visual comparison

## Additional Notes

- implementations use direct summations (not FFT base methods)
- zero-padding ensures equal signal lengths
- best suited for learning and demonstration of DSP concepts

## Requirements 

- MATLAB (basic plotting and vector operations)
- Signal Processing Toolbox required to use the cconv() and xcorr() functions in the 'circular_test_script.m'










