# Time- and Frequency-Domain Convolution and Correlation (MATLAB)

This folder contains MATLAB scripts and functions that demonstrate **convolution** and **cross-correlation** of discrete-time signals in both the **time domain** and the **frequency domain**. A test script is included to compare and visualize results.

---

## Files

### `Time_Domain_Conv.m`
Implements **linear convolution in the time domain** using the direct summation formula.

**Description:**
- Accepts two discrete-time signals
- Performs convolution explicitly using loops and indexing
- Demonstrates the mathematical definition of convolution
- Visualizes input and output signals

---

### `Freq_Domain_Conv.m`
Implements **linear convolution using the frequency domain** (convolution theorem).

**Description:**
- Zero-pads signals to avoid circular convolution artifacts
- Computes FFTs of both input signals
- Multiplies spectra pointwise, then applies the inverse FFT
- Demonstrates that time-domain convolution is equivalent to frequency-domain multiplication:
  `x[n] * h[n]  ⟺  X[k] · H[k]`

---

### `cross_corr.m`
Implements **cross-correlation** between two discrete-time signals.

**Description:**
- Computes similarity between two signals as a function of time shift
- Uses direct summation and indexing
- Useful for delay estimation and signal alignment

---

### `conv_test_script.m`
Test and demonstration script for all convolution and correlation functions.

**Description:**
- Defines example input signals
- Calls time-domain convolution, frequency-domain convolution, and cross-correlation
- Compares results visually and numerically against MATLAB built-ins (`conv`, `xcorr`)

**Usage:**
```matlab
conv_test_script
```

## Requirements

- MATLAB (base)
- Signal Processing Toolbox — required for `xcorr()` in `conv_test_script.m`
