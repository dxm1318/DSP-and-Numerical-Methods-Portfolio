# Discrete Fourier Transform and Short-Time Fourier Transform (MATLAB)

This repository contains MATLAB implementations of the **Discrete Fourier Transform (DFT)**, **Inverse Discrete Fourier Transform (IDFT)**, and **Discrete Short-Time Fourier Transform (DSTFT)**, along with a test script for demonstration and verification.

The code is intended for educational use in signal processing and Fourier analysis.

---

## Files Description

### `DFT.m`
Implements the **Discrete Fourier Transform (DFT)** using the direct mathematical definition.

**Description:**
- Accepts a discrete-time signal in the time domain
- Computes the DFT using explicit summation (no FFT)
- Demonstrates the relationship between time-domain signals and their frequency-domain representations

**Mathematical definition:**

X[k] = $$\sum_{i=0}^{n-1}$$  x[n] $\cdot$ exp(-2jkn $\cdot$ pi/N)


**Output:**
- Frequency-domain representation of the input signal

---

### `IDFT.m`
Implements the **Inverse Discrete Fourier Transform (IDFT)** using the direct mathematical definition.

**Description:**
- Accepts a frequency-domain signal
- Reconstructs the original time-domain signal
- Complements the `DFT.m` implementation

**Mathematical definition:**

x[n] = $\frac{1}{N}$ $$\sum_{i=0}^{n-1}$$  X[k] $\cdot$ exp(-2jkn $\cdot$ pi/N)


**Output:**
- Reconstructed time-domain signal

---

### `DSTFT.m`
Implements the **Discrete Short-Time Fourier Transform (DSTFT)**.

**Description:**
- Splits the input signal into short, overlapping time segments
- Applies the DFT to each segment
- Provides time–frequency analysis of non-stationary signals
- Uses windowing to localize frequency content in time

**Running Instructions**
- Input Number of Desired Analysis Points 'N'
- Input your choice of window between: 'hann', 'hamming', 'blackman', and 'kaiser'
- DSTFT is computed and output displayed

**Output:**
- Time–frequency representation of the signal (depending on implementation, may include magnitude or complex spectrum)

### `Fourier_test_script.m`
Test and demonstration script for the Fourier-related functions.

**Description:**
- Defines example signals
- Calls:
  - `DFT.m`
  - `IDFT.m`
  - `DSTFT.m`
- Verifies correctness of transformations
- May generate plots to visualize:
  - Time-domain signals
  - Frequency-domain spectra
  - Time–frequency representations

**Usage:**
matlab
`Fourier_test_script`

## Additional Notes

- DFT/IDFT implementations use direct summation, not fft based methods
- DSTFT is useful for anlyzing non-stationary signals whose frequency content changes over time

## Software Reuqirements
- Only base MATLAB is required. No additional toolboxes are necessary. 
