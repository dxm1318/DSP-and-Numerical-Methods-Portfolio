# Numerical Methods and Estimation Theory

**Author:** Daniel Martens

## Overview

This folder contains Python and MATLAB code for **numerical analysis** and **estimation theory**.

- **Python** — four small classes that put the core numerical methods behind a consistent interface: root finding, interpolation, numerical differentiation, and numerical integration. Each class validates its inputs, accepts either a Python function or a SymPy expression where a function is needed, and has a built-in plotting method.
- **MATLAB** — Maximum Likelihood Estimation (MLE) and the Cramér-Rao Lower Bound (CRLB), with Monte Carlo verification.

---

## Folder Structure

```
Numerical Methods/
├── Numerical_Methods_py/
│   ├── find_root.py           # FindRoot: bisection, Newton-Raphson, secant
│   ├── interpolation.py       # Interpolation: linear, cubic spline, nearest, Newton, Lagrange
│   ├── differentiation.py     # Differentiation: forward, backward, central, smoothed
│   └── integration.py         # Integration: Riemann sums, trapezoidal, Simpson's, Monte Carlo
└── Numerical Methods MATLAB/
    ├── CRLB.m                 # Cramér-Rao Lower Bound for a DC level in noise
    ├── MC_CRLB.m              # Monte Carlo verification of the CRLB
    ├── MLE.m                  # MLE of sinusoid frequency, amplitude, and phase
    └── MLE_test.m             # Test script for MLE.m
```

---

## Python — Numerical Analysis

| File | Class | Methods |
|------|-------|---------|
| `find_root.py` | `FindRoot` | `bisection`, `newton`, `secant`, `plot` |
| `interpolation.py` | `Interpolation` | `Linear_Interp`, `Cubic_Spline`, `nearest_neighbor`, `Newton_poly`, `Lagrange_poly`, `plot_interpolation` |
| `differentiation.py` | `Differentiation` | `differentiate` (`forward`, `backward`, `central`, `smooth`), `tangent_line`, `plot` |
| `integration.py` | `Integration` | `integrate` (`left`, `right`, `midpoint`, `trapezoidal`, `simpsons`, `monte_carlo`), `plot` |

Each file can be run directly (`python find_root.py`) to execute a demo that prints results and shows plots.

### FindRoot

Root finding for a single-variable function. `f` can be a callable or a SymPy expression with one free variable; for a symbolic `f`, its derivative is computed automatically for Newton-Raphson. Otherwise Newton-Raphson uses a central-difference derivative unless you pass `fprime`. All three methods are iterative rather than recursive, so there is no recursion-depth limit. The iterates from the most recent solve are stored in `history` and drawn by `plot`. If a method does not converge (for example it reaches `max_iter`, or the secant line goes flat), it raises a `RuntimeWarning` with the last iterate and its residual, and `converged` is set to `False`.

```python
from find_root import FindRoot

fr = FindRoot(lambda x: x**2 - 2)
root = fr.bisection(0, 2, tol=1e-10)         # 1.41421356...  (needs a sign change on [a, b])
fr.plot(0, 2, root=root, method='bisection')

from sympy import symbols
t = symbols('t')
FindRoot(t**3 - 8*t - 3).newton(3.5)         # 3.0, derivative found automatically
FindRoot(lambda x: x**2 - 2).secant(1, 2)    # no derivative needed
```

### Interpolation

Build the object from data points `(x, y)` (sorted on construction), then call a method with an array or list of query points `X`. Every method returns a dictionary with the sorted query points `X`, the interpolated values `Y`, the `method` name, and a `func` callable that `plot_interpolation` uses to draw the curve. `Cubic_Spline` supports `'natural'` and `'clamped'` end conditions (set the end slopes with `D1` and `Dn`). `Newton_poly` and `Lagrange_poly` require unique `x` values and extrapolate with a warning outside the data range; the other methods raise an error instead.

```python
from interpolation import Interpolation

interp = Interpolation([0, 1, 2, 3, 4, 5], [2, 4, 3, 4, 7, 1])
out = interp.Cubic_Spline([0.5, 1.5, 2.25], bc_type='natural')
out['Y']                                     # interpolated values
interp.plot_interpolation(out)               # pass ax=... to draw into an existing subplot
```

### Differentiation

Numerical derivatives of `f` over `[a, b]` on `n` evenly spaced points. `differentiate` returns `(dfx, X)`. The `'smooth'` method differentiates a moving average of `2*window + 1` points centered on each sample, which helps with noisy data (`noise_std` adds Gaussian noise to test it). `tangent_line` returns the slope and sample points of the tangent at a point.

```python
import numpy as np
from differentiation import Differentiation

d = Differentiation(np.sin)
dfx, X = d.differentiate(0, 2*np.pi, n=100, method='central')
d.plot(0, 2*np.pi, n=100, method='central', point=np.pi/4)   # also draws the tangent line
```

### Integration

Numerical integration of `f` over `[a, b]` using `n` points. Simpson's rule needs an odd `n`; for `'monte_carlo'`, `n` is the number of random samples. `plot` shows the subintervals used by the chosen method along with the approximate area.

```python
import numpy as np
from integration import Integration

ig = Integration(np.sin)
ig.integrate(0, np.pi, 101, method='simpsons')     # 2.0  (exact area = 2)
ig.plot(0, np.pi, n=11, method='trapezoidal')
```

---

## MATLAB — Estimation Theory

| File | Description |
|------|-------------|
| `CRLB.m` | Simulates a DC level A in white Gaussian noise, estimates A with the sample mean, and returns the squared error alongside the theoretical Cramér-Rao Lower Bound (`var/N`) |
| `MC_CRLB.m` | Monte Carlo verification over 5000 trials; plots the running MSE of the estimates of the mean (A) and the variance (B) converging to their CRLBs |
| `MLE.m` | Maximum Likelihood Estimator for the frequency, amplitude, and phase of a sinusoid in noise. The frequency minimizes the cost function J(f) = ‖x − H·α‖²: a coarse grid search locates the minimum, then `fminbnd` refines it to high precision (a grid alone is limited to a resolution of 1/(N−1)). Amplitude and phase come from the least-squares fit at that frequency. Plots the cost function and the reconstructed signal |
| `MLE_test.m` | Test script for `MLE.m` with predefined parameters |

**Note:** For a real-valued sinusoid, a frequency `f` and its mirror `1 − f` fit the data equally well, so `MLE.m` may report either one. When it reports the mirror, the phase comes back as `2π − φ`; the reconstructed signal is the same in both cases.

**Usage:** Open the files in MATLAB and run them directly, or call the functions from the command window.

---

## Requirements

- Python 3.9 or later with **NumPy**, **Matplotlib**, and **SymPy**
- MATLAB R2021a or later (`MLE.m` uses name=value plot arguments)
