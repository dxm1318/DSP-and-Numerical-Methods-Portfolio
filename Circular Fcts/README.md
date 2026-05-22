# Circular Convolution and Correlation (MATLAB)

This folder contains MATLAB implementations of **circular convolution** and **circular correlation**, along with a test script that compares the custom functions against MATLAB's built-in functions.

---

## Files

### `circular_conv.m`
Implements **circular convolution** of two discrete-time signals using the definition-based summation formula.

**Key features:**
- Accepts two input sequences `x` and `h`
- Converts inputs to row vectors
- Zero-pads both signals to length `N = length(x) + length(h) - 1`
- Computes circular convolution using nested loops and modular indexing
- Plots input signals `x[n]` and `h[n]`, and the convolution output

**Function signature:**
```matlab
y = circular_conv(x, h)
```

---

### `circular_corr.m`
Implements **circular correlation** between two discrete-time signals.

**Key features:**
- Accepts two input sequences `x` and `h`
- Converts inputs to row vectors
- Zero-pads signals to a common length `N = length(x) + length(h) - 1`
- Computes circular correlation using modular indexing
- Identifies and highlights the maximum correlation value and its shift index on the plot

**Function signature:**
```matlab
y = circular_corr(x, h)
```

---

### `circular_test_script.m`
Script designed to test and compare custom implementations against MATLAB built-ins.

**Comparisons made:**
- Linear convolution (`conv`) vs. MATLAB circular convolution (`cconv`) vs. `circular_conv`
- Linear cross-correlation (`xcorr`) vs. `circular_corr`
- Produces figures for visual comparison

---

## Notes

- Implementations use direct summation — no FFT-based methods
- Zero-padding ensures equal signal lengths before modular indexing
- Suited for learning and demonstrating circular DSP operations

## Requirements

- MATLAB (basic plotting and vector operations)
- Signal Processing Toolbox — required for `cconv()` and `xcorr()` in `circular_test_script.m`
