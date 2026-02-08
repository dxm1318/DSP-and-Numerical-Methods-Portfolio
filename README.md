# Time- and Frequency-Domain Convolution and Correlation (MATLAB)

This repository contains MATLAB scripts and functions that demonstrate **convolution** and **cross-correlation** of discrete-time signals in both the **time domain** and the **frequency domain**. A test script is included to compare and visualize results.

The code is intended to demonstrate knowledge of DSP concepts as well as for educational use in signal processing courses.

---

## Files Description

### `Time_Domain_Conv.m`
Implements **linear convolution in the time domain** using the direct summation formula.

**Description:**
- Accepts two discrete-time signals
- Performs convolution explicitly using loops and indexing
- Demonstrates the mathematical definition of convolution
- Suitable for understanding the time-domain convolution process

**Typical output:**
- Convolved signal in the time domain
- Optional visualization of the input and output signals

---

### `Freq_Domain_Conv.m`
Implements **linear convolution using the frequency domain** approach.

**Description:**
- Uses the convolution theorem
- Signals are zero-padded to avoid circular convolution
- Computes FFTs of the input signals
- Multiplies spectra pointwise
- Applies inverse FFT to obtain the linear convolution result

**Key concept:**

- `x[n] * h[n]` =  `X[k]` $\cdot$  `H[k]`
- Time Domain Multiplication is equivalent to Frequency Domain Mulitplication


**Purpose:**
- Demonstrates equivalence between time-domain and frequency-domain convolution
- Highlights computational advantages of FFT-based convolution

---

### `cross_corr.m`
Implements **cross-correlation** between two discrete-time signals.

**Description:**
- Computes similarity between two signals as a function of time shift
- Uses direct summation and indexing
- Identifies alignment between signals
- Useful for delay estimation and signal matching

**Output:**
- Cross-correlation sequence
- Corresponding lag indices (depending on implementation)

---

### `conv_test_script.m`
Test and demonstration script for convolution and correlation functions.

**Description:**
- Defines example input signals
- Calls:
  - Time-domain convolution
  - Frequency-domain convolution
  - Cross-correlation function
- Compares results visually and numerically
- May use MATLAB built-in functions (e.g., `conv`, `xcorr`) for verification

**Usage:**
matlab
`conv_test_script`

**Requirements**
- standard MATLAB
- Signal Processing Toolbox to use `xcorr()` function in `conv_test_script.m`


