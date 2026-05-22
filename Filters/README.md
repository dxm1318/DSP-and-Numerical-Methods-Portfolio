# MATLAB Biquad Filters

**Author:** Daniel Martens

## Overview

This folder provides object-oriented MATLAB implementations of digital biquad filters. It includes support for low-pass (LPF), high-pass (HPF), and peaking filters, along with test scripts to visualize frequency response and process audio signals.

---

## File Overview

### HPF/LPF Biquad

| File | Description |
|------|-------------|
| `biquad.m` | Class definition for LPF and HPF biquad filters |
| `biquad_test.m` | Test script — frequency response plots and signal processing verification |

### Peaking Filter

| File | Description |
|------|-------------|
| `biquad_filter.m` | Class definition for a parametric peaking filter |
| `biquad_filter_test.m` | Test script — chirp signal input, spectrogram output |
| `flute.wav` | Sample audio file used in testing |

---

## Requirements

### MATLAB Version
- Recommended: MATLAB R2019b or later
- Minimum: MATLAB R2016b (required for `classdef` and updated signal processing functions)

### Signal Processing Toolbox
Required for:
- `freqz()` — frequency response visualization
- `spectrogram()` — peaking filter test script
- `chirp()` — exponential sine sweep generation
- `db2mag()` — dB to magnitude conversion
