# Audio Feature and Spectral Analysis (MATLAB)

This folder contains MATLAB scripts for **audio signal analysis**, focusing on spectral features and perceptual characteristics such as **spectral centroid**, **loudness**, and **buffer-based spectral analysis**. A test script demonstrates and validates the full analysis pipeline.

---

## Files

### `buffer_spec_analysis.m`
Performs **frame-based spectral analysis** on an audio signal.

**Description:**
- Segments the input signal into short-time buffers (frames)
- Applies spectral analysis to each buffer
- Tracks how spectral content evolves over time
- Forms the basis for further feature extraction

---

### `sc_analysis.m`
Computes the **spectral centroid** of an audio signal.

**Description:**
- Estimates the center of mass of the magnitude spectrum
- Provides a measure related to the perceived *brightness* of a sound
- Computed on a frame-by-frame basis

**Output:** Spectral centroid values over time

---

### `loudness_analysis.m`
Performs **loudness analysis** on an audio signal.

**Description:**
- Estimates loudness based on amplitude or energy measures
- Tracks perceived intensity changes over time
- Complements spectral features in audio characterization

**Output:** Loudness values per frame or over the full signal

---

### `test_script.m`
Entry point for the full audio analysis pipeline.

**Description:**
- Loads or defines an example audio signal
- Calls `buffer_spec_analysis`, `sc_analysis`, and `loudness_analysis`
- Visualizes all features using plots

**Usage:**
```matlab
test_script
```

## Requirements

- MATLAB (base)
- Signal Processing Toolbox — `hann()`, `hamming()`, `spectrogram()`
