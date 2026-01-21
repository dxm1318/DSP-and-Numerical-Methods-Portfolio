Numerical Methods & Estimation Theory

Author: Daniel Martens

Overview

This folder contains a collection of Python and MATLAB scripts demonstrating fundamental numerical analysis 
techniques and estimation theory concepts. The projects cover a wide range of topics including root finding, 
numerical integration, Monte Carlo simulations, differentiation, and Maximum Likelihood Estimation (MLE).

Descriptions
   
   1. Numerical Analysis (Python)
      I. Root Finding Algorithms
        * bisection_method.py
            - Implements the Bisection Method to find roots of a non-linear function defined as
              f(x) = 4 - x\ln(x)$
            - Accepts user input for initial interval guesses a and b
            - Validates interval to ensure sign change f(a) * f(b) < 0
            - iteratively narrows the interval until the root is found within a specified tolerance
        * muellersmethod.py
            - Implements Müller's Method for finding complex roots of polynomials
            - Uses Horner's method for efficient polynomial and derivative evaluation
            - Initializes using two steps of Newton's method
            - Solves the quadratic approximation to find complex roots
            - Outputs the root and iteration count upon convergence
      II. Numerical Integration
        * Gaussian_Adaptive.py
            - performs numerical integration using Adaptive Gaussian Quadrature
            - integrates the function f(x) = x^2 *ln(2x+5)
            - recursively subdivides the integration interval until the error between coarse and fine estimates
              below a tolerance
            - includes a recursion depth limit of 50 levels to prevent infinite loops
        * Monte_Carlo.py
            - Demonstrates Monte Carlo integration to estimate the area of a defined 2D region and the
              integral of a function f(x,y) = xy over that region
            - Uses rejection sampling to estimate the area
            - Computes the integral estimate using the Mean Value Theorem
        * Monte_Carlo_3D.py
            - Extends Monte Carlo integration to 3 dimensions to estimate the integral of
              f(x,y,z) = y*x^2 + z*ln(y) + exp(x)
            - integrates over a rectangular volume defined by x in [-1,1], y in [3,6] and z in [0,2]
            - demonstrates convergence as the sample size (N) increases
      III. Numerical Differentiation
        * richardsonextrapolation.py
            - Approximates the derivative of a function using Richardson Extrapolation to improve the
              accuracy of the central difference method
            - Constructs a table of approximations where each column eliminates a higher-order error
              term (O(h^2), O(h^4), etc.)
            - checks for convergence against a tolerance (1e-12)
      IV. Ordinary Differential Equations (ODEs)
        * Rk4.py
            - Implements the Classical 4th-Order Runge-Kutta (RK4) method to solve a system of first-order
              ordinary differential equations
            - includes a generic rk4_step function capable of handling n-dimensional systems
    
  2. Estimation Theory (MATLAB)
       I. Cramer Rao Lower Bound (CRLB)
         * CRLB.m
             - Calculates the theoretical Cramer-Rao Lower Bound and the squared error for a simple
               DC signal in white Gaussian noise.
         * MC_CRLB.m
             - Performs a Monte Carlo simulation to verify the CRLB for estimating the Mean (A) and
               Variance (B) of a signal
             - runs 5000 trials to compute the Mean Squared Error (MSE) of the estimators
             - Visualizes the convergence of the estimated MSE to the theoretical CRLB lines for both parameters
         * MLE.m
             - Implements a Maximum Likelihood Estimator to recover frequency, amplitude, and phase of a
               sinusoidal signal in noise
             - iterates through frequency candidatges to minimize the cost function J(f) = ||x-H*alpha||^2
             - Solves for amplitude and phase once the frequency is estimated using Linear Least Squares
             - Plots the cost function vs. frequency and compares the reconstructed signal against the noisy
               input
          * MLE_test.m
             - a test script to execute the MLE function with defined parameters

Prerequisites

Python 3.x (standard libraries: math, random, cmath)
MATLAB (R2018a or later)

Usage

Python scripts --> run from terminal or IDE
MATLAB Scripts --> Open files in MATLAB













         
