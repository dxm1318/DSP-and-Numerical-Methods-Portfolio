# Discrete Fourier Transform and Short-Time Fourier Transform (MATLAB)

This folder contains MATLAB implementations of the **Discrete Fourier Transform (DFT)**, **Inverse Discrete Fourier Transform (IDFT)**, and **Discrete Short-Time Fourier Transform (DSTFT)**, along with a test script for demonstration and verification.

---

## Files

### `DFT.m`
Implements the **Discrete Fourier Transform** using the direct mathematical definition (no FFT).

**Description:**
- Accepts a discrete-time signal
- Computes the DFT via explicit summation:
  `X[k] = sum over n of x[n] * exp(-j*2*pi*k*n/N)`
- Returns the frequency-domain representation of the input signal

---

### `IDFT.m`
Implements the **Inverse Discrete Fourier Transform** using the direct mathematical definition.

**Description:**
- Accepts a frequency-domain signal
- Reconstructs the original time-domain signal:
  `x[n] = (1/N) * sum over k of X[k] * exp(j*2*pi*k*n/N)`
- Complements the `DFT.m` implementation

---

### `DSTFT.m`
Implements the **Discrete Short-Time Fourier Transform**.

**Description:**
- Splits the input signal into short, overlapping time segments
- Applies the DFT to each segment
- Provides time–frequency analysis of non-stationary signals

**Running instructions:**
1. Input the number of desired analysis points `N`
2. Select a window type: `hann`, `hamming`, `blackman`, or `kaiser`
3. DSTFT is computed and the time–frequency output is displayed

---

### `Fourier_test_script.m`
Test and demonstration script for all Fourier functions.

**Description:**
- Defines example signals and calls `DFT.m`, `IDFT.m`, and `DSTFT.m`
- Verifies correctness of forward and inverse transforms
- Generates plots of time-domain signals, frequency spectra, and time–frequency representations

**Usage:**
```matlab
Fourier_test_script
```

---

## Notes

- DFT and IDFT use direct summation — no calls to MATLAB's built-in `fft`
- DSTFT is useful for analyzing non-stationary signals whose frequency content changes over time

## Requirements

- Base MATLAB only — no toolboxes required
