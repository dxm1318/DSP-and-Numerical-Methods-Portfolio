# Digital Signal Processing and Data Analysis Scripts (MATLAB)

This folder contains MATLAB scripts related to **digital signal processing (DSP)** and **data analysis**, developed for educational purposes. Scripts cover DSP fundamentals and exercises from *Digital Audio Theory: A Practical Guide* by Christopher L. Bennett.

---

## Files

### `DSP_Basics.m`
Introduces **fundamental DSP concepts** through working examples.

**Covers:**
- Discrete-time signal representation and visualization
- Z-plane pole/zero plots (`zplane`)
- Frequency response (`freqz`)
- Spectrograms

---

### `DAT_Ch2.m`
MATLAB exercises corresponding to **Chapter 2** of *Digital Audio Theory: A Practical Guide*.

**Covers:**
- Signal representation in the discrete-time domain
- Basic operations on discrete signals
- Visualization of results

---

### `DAT_Ch10_Project.m`
Project-scale script corresponding to **Chapter 10**.

**Covers:**
- Multi-stage signal processing pipeline
- Filtering with `filtfilt`
- Analysis and visualization of real or simulated audio data

---

## Usage

Run any script directly from the MATLAB command window:

```matlab
DSP_Basics
DAT_Ch2
DAT_Ch10_Project
```

## Requirements

- MATLAB (base)
- Signal Processing Toolbox — `filtfilt()`, `freqz()` in `DAT_Ch10_Project.m`; `zplane()`, `freqz()`, `spectrogram()` in `DSP_Basics.m`
