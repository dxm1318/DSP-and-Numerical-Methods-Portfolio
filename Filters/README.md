# MATLAB Biquad Filters

Author: Daniel Martens

## Overview

This folder provides a object-oriented MATLAB implementation of digital biquad filters. It includes support for low pass (LPF), high pass (HPF), and peaking filters, along with scripts to visualize frequency response and process audio signals. 

## System Requirements

### MATLAB Version
  * reccomended: MATLAB R2019b or later
  * minimum: MATLAB R2016b required for classdef and updated signal processing functions
### Required Toolbox
Signal Processing Toolbox
  * freqz(): visualize frequency response
  * spectrogram(): used in peaking filter test script
  * chirp(): generate Exponential Sine Sweep (ESS)
  * db2mag(): convert dB to magnitude

## File Overview

**biquad.m**: class definition for standard LPF and HPF filters

**biquad_test.m**: test script for biquad.m

**biquad_filter.m**: class definition for a peaking filter

**biquad_filter_test.m**: test script biquad_filter.m
              
                  
  
