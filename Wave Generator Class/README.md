# Waveform Generation and Analysis (MATLAB)

This repository contains MATLAB scripts for **generating, visualizing, and testing waveforms**. The code is intended for educational use in courses related to signals, waves, or digital signal processing.

---

## Files Description

### `Waves.m`
Core script or function for **waveform generation**.

**Description:**
- Generates one or more waveforms (e.g., sinusoidal or other basic signals)
- Defines key signal parameters such as:
  - Frequency
  - Amplitude
  - Phase
  - Sampling time or duration
- Produces time-domain representations of waves
- May include plots for visualization

**Purpose:**
- Demonstrate fundamental wave properties
- Serve as the main signal-generation module used by other scripts

---

### `Waves_test.m`
Test and demonstration script for the waveform generator.

**Description:**
- Calls `Waves.m`
- Tests waveform generation under different parameter settings
- Visualizes results using plots
- Serves as an entry point for running and validating the waveform code

**Usage:**
matlab
`Waves_test`

##Software Requirements
- Base MATLAB
- Signal Processing Toolbox: `sawtooth()`, `square()`, and `spectrogram()` in `Waves.m`
