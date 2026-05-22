# Waveform Generation and Analysis (MATLAB)

This folder contains an object-oriented MATLAB class for **generating, visualizing, and testing waveforms**. Intended for use in signals, waves, or digital signal processing coursework.

---

## Files

### `Waves.m`
OOP class for **waveform generation**.

**Description:**
- Generates standard waveforms: sine, square, sawtooth, and others
- Configurable parameters: frequency, amplitude, phase, sampling rate, and duration
- Produces time-domain signal arrays and plots for visualization
- Designed as a reusable signal source for other DSP scripts

**Usage:**
```matlab
w = Waves(frequency, amplitude, phase, duration, sample_rate);
```

---

### `Waves_test.m`
Test and demonstration script for the waveform generator.

**Description:**
- Instantiates `Waves` with various parameter configurations
- Verifies waveform output through plots
- Tests edge cases and parameter boundaries

**Usage:**
```matlab
Waves_test
```

## Requirements

- MATLAB (base)
- Signal Processing Toolbox — `sawtooth()`, `square()`, `spectrogram()` in `Waves.m`
