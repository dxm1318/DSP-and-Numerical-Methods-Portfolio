# MATLAB DSP Toolkit

Author: Daniel Martens

## Overview

This repository contains a collection of MATLAB functions and scripts designed to implement and visualize fundamental Digital Signal Processing concepts, including convolution, correlation, and Fourier analysis.

## Core Functionalities

### 1. Convolution Operations
  * Time Domian Convolution: 
  * Frequency Domain Convolution
  * Circular Convolution

### 2. Correlation Analysis
  * Cross-Correlation
  * Circular Correlation

### 3. Fourier Analysis
  * Discrete Fourier Transform
  * Spectral Visualization

## File Description
   * **DFT.m**: 	Computes the N-point DFT of an input signal.
   * **Time_Domain_Conv.m**:	Manual implementation of linear convolution with visualization of input/output
   * **Freq_Domain_Conv.m**: Uses FFT and IFFT to perform convolution in the frequency domain
   * **circular_conv.m**: Implements circular convolution and plots periodic input signals
   * **circular_corr.m**: Computes circular correlation and prints the maximum correlation shift
   * **cross_corr.m**:	A custom function for linear cross-correlation
   * **Fourier_test_script.m**:	Compares manual DFT results with MATLAB's built-in fft and tests signal              reconstruction via IDFT
   * **circular_test_script.m**:	Compares linear vs. circular convolution and cross-correlation vs. circular              correlation
   * **conv_test_script.m**: Tests time-domain convolution using a 440Hz sine wave and an impulse response

## Requirements

**MATLAB minimum version**: R2016b or later is recommended
**Required Toolboxes**: 
   * MATLAB(Base): Most functions are includded in the standard MATLAB installation (fft, ifft, conv, stem,         plot)
   * Signal Processing Toolbox: Required specifically for the xcorr function used in "circular_test_script.m"       but the custom functions will still run
