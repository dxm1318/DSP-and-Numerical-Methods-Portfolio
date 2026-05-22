# DSP and Numerical Methods Portfolio

A collection of MATLAB and Python implementations covering core topics in **digital signal processing (DSP)** and **numerical methods**, developed for coursework and self-study. Each module is self-contained with its own README and test scripts.

---

## Modules

| Folder | Language | Topics |
|--------|----------|--------|
| [Circular Fcts](#circular-fcts) | MATLAB | Circular convolution, circular correlation |
| [Convolution Fcts](#convolution-fcts) | MATLAB | Time-domain & frequency-domain convolution, cross-correlation |
| [DSP Scripts](#dsp-scripts) | MATLAB | DSP fundamentals, textbook exercises, applied project |
| [Filters](#filters) | MATLAB (OOP) | Biquad LPF/HPF, peaking filter |
| [Fourier Transform](#fourier-transform) | MATLAB | DFT, IDFT, DSTFT (Short-Time Fourier Transform) |
| [Numerical Methods](#numerical-methods) | Python + MATLAB | Root finding, integration, ODE solvers, MLE, CRLB |
| [Signal Analysis](#signal-analysis) | MATLAB | Spectral centroid, loudness, buffer-based spectral analysis |
| [Wave Generator Class](#wave-generator-class) | MATLAB (OOP) | Waveform generation and visualization |

---

## Repository Structure

```
DSP-and-Numerical-Methods-Portfolio/
├── Circular Fcts/
│   ├── circular_conv.m           # Circular convolution (definition-based)
│   ├── circular_corr.m           # Circular correlation with peak detection
│   └── circular_test_script.m    # Comparison against MATLAB built-ins
│
├── Convolution Fcts/
│   ├── Time_Domain_Conv.m        # Linear convolution via direct summation
│   ├── Freq_Domain_Conv.m        # Convolution via FFT (convolution theorem)
│   ├── cross_corr.m              # Cross-correlation via direct summation
│   └── conv_test_script.m        # Verification and visualization script
│
├── DSP Scripts/
│   ├── DSP_Basics.m              # Discrete-time signals, transforms, visualization
│   ├── DAT_Ch2.m                 # Chapter 2 exercises (Digital Audio Theory)
│   └── DAT_Ch10_Project.m        # Chapter 10 project — full DSP pipeline
│
├── Filters/
│   ├── HPF:LPF Biquad/
│   │   ├── biquad.m              # Biquad class definition (LPF and HPF)
│   │   └── biquad_test.m         # Test script for biquad filters
│   └── Peaking Filter/
│       ├── biquad_filter.m       # Peaking filter class definition
│       ├── biquad_filter_test.m  # Test script (uses chirp signal + spectrogram)
│       └── flute.wav             # Sample audio file for testing
│
├── Fourier Transform/
│   ├── DFT.m                     # DFT via direct summation
│   ├── IDFT.m                    # IDFT via direct summation
│   ├── DSTFT.m                   # Short-Time Fourier Transform with windowing
│   └── Fourier_test_script.m     # Verification and visualization script
│
├── Numerical Methods/
│   ├── Numerical Methods Python/
│   │   ├── bisection_method.py   # Bisection method for root finding
│   │   ├── muellersmethod.py     # Müller's method for complex roots
│   │   ├── Gaussian_Adaptive.py  # Adaptive Gaussian quadrature
│   │   ├── Monte_Carlo.py        # 2D Monte Carlo integration
│   │   ├── Monte_Carlo_3D.py     # 3D Monte Carlo integration
│   │   ├── richardsonextrapolation.py  # Richardson extrapolation for derivatives
│   │   └── RK4.py                # 4th-order Runge-Kutta ODE solver
│   └── Numerical Methods MATLAB/
│       ├── CRLB.m                # Cramér-Rao Lower Bound calculation
│       ├── MC_CRLB.m             # Monte Carlo verification of CRLB (5000 trials)
│       ├── MLE.m                 # Maximum Likelihood Estimator (frequency, amplitude, phase)
│       └── MLE_test.m            # Test script for MLE
│
├── Signal Analysis/
│   ├── buffer_spec_analysis.m    # Frame-based spectral analysis
│   ├── sc_analysis.m             # Spectral centroid estimation
│   ├── loudness_analysis.m       # Loudness/energy analysis
│   └── test_script.m             # Entry point for the full analysis pipeline
│
└── Wave Generator Class/
    ├── Waves.m                   # OOP waveform generator (sine, square, sawtooth, etc.)
    └── Waves_test.m              # Test script with parameter sweeps and plots
```

---

## Module Descriptions

### Circular Fcts

MATLAB implementations of **circular convolution** and **circular correlation** built from the definition using modular indexing — no FFT. Both functions zero-pad inputs to a common length `N = length(x) + length(h) - 1`. The test script benchmarks results against MATLAB's built-in `cconv` and `xcorr`.

**Requirements:** MATLAB, Signal Processing Toolbox (`cconv`, `xcorr` in test script only)

---

### Convolution Fcts

Two implementations of **linear convolution** — one in the time domain (direct summation) and one in the frequency domain (via FFT and the convolution theorem). Demonstrates that multiplication in the frequency domain is equivalent to convolution in the time domain. Also includes a **cross-correlation** function for measuring signal similarity across time shifts.

**Requirements:** MATLAB, Signal Processing Toolbox (`xcorr` in test script only)

---

### DSP Scripts

MATLAB scripts developed from *Digital Audio Theory: A Practical Guide* by Christopher L. Bennett, covering foundational DSP concepts and progressing to a full project-scale application.

| Script | Description |
|--------|-------------|
| `DSP_Basics.m` | Discrete-time signals, z-plane visualization, spectrograms |
| `DAT_Ch2.m` | Chapter 2 signal representation exercises |
| `DAT_Ch10_Project.m` | Full DSP pipeline — filtering, analysis, and visualization |

**Requirements:** MATLAB, Signal Processing Toolbox (`filtfilt`, `freqz`, `zplane`, `spectrogram`)

---

### Filters

Object-oriented MATLAB implementations of **digital biquad filters**. Each filter type is defined as a MATLAB class with configurable parameters and includes a corresponding test script.

| File | Description |
|------|-------------|
| `biquad.m` | Class for low-pass (LPF) and high-pass (HPF) biquad filters |
| `biquad_test.m` | Frequency response visualization and signal processing test |
| `biquad_filter.m` | Class for a parametric peaking filter |
| `biquad_filter_test.m` | Test using a chirp signal and `flute.wav`; plots spectrogram |

**Requirements:** MATLAB R2016b or later, Signal Processing Toolbox (`freqz`, `spectrogram`, `chirp`, `db2mag`)

---

### Fourier Transform

From-scratch MATLAB implementations of the **DFT**, **IDFT**, and **DSTFT** — all using direct summation with no calls to MATLAB's built-in `fft`. The DSTFT supports selectable windows (`hann`, `hamming`, `blackman`, `kaiser`) and produces a time–frequency representation useful for non-stationary signal analysis.

**Requirements:** Base MATLAB only (no toolboxes required)

---

### Numerical Methods

A two-part collection covering **numerical analysis** (Python) and **estimation theory** (MATLAB).

**Python — Numerical Analysis**

| Script | Method |
|--------|--------|
| `bisection_method.py` | Bisection root finding for f(x) = 4 − x·ln(x) |
| `muellersmethod.py` | Müller's method for complex polynomial roots (Horner's evaluation) |
| `Gaussian_Adaptive.py` | Adaptive Gaussian quadrature with recursive interval subdivision |
| `Monte_Carlo.py` | 2D Monte Carlo integration via rejection sampling |
| `Monte_Carlo_3D.py` | 3D Monte Carlo integration over a rectangular volume |
| `richardsonextrapolation.py` | Richardson extrapolation table for derivative approximation |
| `RK4.py` | Classical 4th-order Runge-Kutta for n-dimensional ODE systems |

**MATLAB — Estimation Theory**

| Script | Description |
|--------|-------------|
| `CRLB.m` | Cramér-Rao Lower Bound for DC signal in white Gaussian noise |
| `MC_CRLB.m` | Monte Carlo verification of CRLB over 5000 trials |
| `MLE.m` | MLE for sinusoidal frequency, amplitude, and phase recovery |
| `MLE_test.m` | Test script for `MLE.m` |

**Requirements:** Python 3.x (standard library only) · MATLAB R2018a or later

---

### Signal Analysis

MATLAB scripts for **perceptual and spectral audio feature extraction**, designed for frame-by-frame analysis of audio signals.

| Script | Feature |
|--------|---------|
| `buffer_spec_analysis.m` | Frame-based spectral analysis — how spectrum evolves over time |
| `sc_analysis.m` | Spectral centroid — perceived brightness of a sound |
| `loudness_analysis.m` | Loudness/energy tracking over time |
| `test_script.m` | Runs the full analysis pipeline and plots all features |

**Requirements:** MATLAB, Signal Processing Toolbox (`hann`, `hamming`, `spectrogram`)

---

### Wave Generator Class

An object-oriented MATLAB class for generating and visualizing standard waveforms (sine, square, sawtooth, and others). Configurable frequency, amplitude, phase, and duration parameters. Designed as a reusable signal generation utility for other DSP scripts.

**Requirements:** MATLAB, Signal Processing Toolbox (`sawtooth`, `square`, `spectrogram`)

---

## Requirements Summary

| Requirement | Used In |
|-------------|---------|
| MATLAB (R2016b+) | All MATLAB modules |
| MATLAB Signal Processing Toolbox | Convolution Fcts, DSP Scripts, Filters, Signal Analysis, Wave Generator Class |
| MATLAB Statistics & Machine Learning Toolbox | *(none at root level)* |
| Python 3.x (standard library) | Numerical Methods — Python scripts |
