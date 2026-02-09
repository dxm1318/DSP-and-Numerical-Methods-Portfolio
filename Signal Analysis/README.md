# Audio Feature and Spectral Analysis (MATLAB)

This repository contains MATLAB scripts for **audio signal analysis**, focusing on spectral features and perceptual characteristics such as **spectral centroid**, **loudness**, and **buffer-based spectral analysis**. A test script is included to demonstrate and validate the functionality of the analysis modules.

The code is intended for educational and experimental use in digital signal processing and audio analysis.

---

## Files Description

### `buffer_spec_analysis.m`
Performs **buffer-based spectral analysis** on an audio signal.

**Description:**
- Segments the input signal into short-time buffers (frames)
- Applies spectral analysis to each buffer
- Useful for short-time or frame-based processing of audio signals
- Forms the basis for time–frequency analysis

**Purpose:**
- Analyze how spectral content evolves over time
- Support feature extraction from buffered signals

---

### `sc_analysis.m`
Computes the **spectral centroid** of an audio signal.

**Description:**
- Estimates the center of mass of the magnitude spectrum
- Provides a measure related to the perceived *brightness* of a sound
- Typically computed on a frame-by-frame basis

**Output:**
- Spectral centroid values over time or per frame

---

### `loudness_analysis.m`
Performs **loudness analysis** on an audio signal.

**Description:**
- Estimates signal loudness based on amplitude or energy-related measures
- Can be used to track perceived intensity changes over time
- Complements spectral features in audio characterization

**Output:**
- Loudness values for the analyzed signal or frames

---

### `test_script.m`
Test and demonstration script for the audio analysis functions.

**Description:**
- Loads or defines an example audio signal
- Calls:
  - `buffer_spec_analysis`
  - `sc_analysis`
  - `loudness_analysis`
- Visualizes results using plots
- Serves as an entry point for running and validating the analysis pipeline

**Usage:**
matlab
`test_script`

## Software Requirements 
- Base MATLAB
- MATLAB Signal Processing Toolbox: hann(), hamming(), spectrogram()
