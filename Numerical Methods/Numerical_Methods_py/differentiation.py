#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Sep 1 2026

@author: danielmartens

Differentiation: a small class containing the numerical differentiation
methods (forward, backward, central, and a smoothed central difference for
noisy data) behind one interface.

Split out of the former differentiation_integration.py; the integration
methods now live in integration.py.
"""

import numbers

import numpy as np
import matplotlib.pyplot as plt
from sympy import Expr, lambdify


class Differentiation:

    METHODS = ['forward', 'backward', 'central', 'smooth']

    def __init__(self, f):
        self.f = f
        self._validate()

    # ------------------------------------------------------------------
    # Validation
    # ------------------------------------------------------------------

    def _validate(self):

        if not (callable(self.f) or isinstance(self.f, Expr)):
            raise TypeError('f must be a callable or symbolic function')

        if isinstance(self.f, Expr):
            free_syms = list(self.f.free_symbols)
            if len(free_syms) != 1:
                raise ValueError('symbolic function must have exactly one free variable')
            self.f = lambdify(free_syms[0], self.f, 'numpy')

        print(f"Available differentiation methods: {', '.join(self.METHODS)}")

    @staticmethod
    def _validate_bounds(a, b, n):
        if not (isinstance(a, numbers.Real) and isinstance(b, numbers.Real)
                and isinstance(n, numbers.Integral)):
            raise TypeError('a and b must be a float or int. n must be an integer')
        if a >= b:
            raise ValueError('a must be strictly less than b')
        if n < 2:
            raise ValueError('n must be at least 2')

    # ------------------------------------------------------------------
    # Differentiation
    # ------------------------------------------------------------------

    def differentiate(self, a, b, n=200, method='central', window=4, noise_std=0.0):
        '''Numerically differentiate f over [a, b] using n points.

        method: 'forward', 'backward', 'central', or 'smooth'
        window, noise_std: only used by method='smooth'; each point is
        smoothed with a moving average over the 2*window + 1 points centered
        on it
        returns (dfx, X)
        '''
        self._validate_bounds(a, b, n)

        method = method.lower()
        if method not in self.METHODS:
            raise ValueError(f"method must be one of {self.METHODS}")

        x = np.linspace(a, b, n)

        if method == 'forward':
            dfx = np.diff(self.f(x)) / np.diff(x)
            X = x[:-1]

        elif method == 'backward':
            dfx = (self.f(x[1:]) - self.f(x[:-1])) / (x[1:] - x[:-1])
            X = x[1:]

        elif method == 'central':
            dfx = (self.f(x[2:]) - self.f(x[:-2])) / (x[2:] - x[:-2])
            X = x[1:-1]

        else:  # smooth
            y = self.f(x)
            if noise_std:
                y = y + np.random.randn(len(y)) * noise_std
            dfx, X = self._smooth_central_diff(x, y, window)

        return dfx, X

    @staticmethod
    def _smooth_central_diff(x, y, n):
        '''central difference of a moving-average-smoothed signal

        the average at index i uses y[i-n .. i+n] (2n + 1 points), so it is
        centered on x[i]
        '''

        y_smooth = []
        X = []
        for i in range(n, len(y) - n):
            y_smooth.append(np.mean(y[i - n:i + n + 1]))
            X.append(x[i])

        y_smooth = np.array(y_smooth)
        X = np.array(X)
        dfx = (y_smooth[2:] - y_smooth[:-2]) / (X[2:] - X[:-2])
        return dfx, X[1:-1]

    def tangent_line(self, x0, span=1.0, npts=20):
        '''slope and sample points of the tangent line to f at x0'''

        h = 1e-5
        slope = (self.f(x0 + h) - self.f(x0 - h)) / (2 * h)
        y0 = self.f(x0)
        tx = np.linspace(x0 - span / 2, x0 + span / 2, npts)
        ty = y0 + slope * (tx - x0)
        return slope, tx, ty

    # ------------------------------------------------------------------
    # Plotting
    # ------------------------------------------------------------------

    def plot(self, a, b, n=100, method='central', point=None, figsize=(10, 6), **kwargs):
        '''Plot f and its numerical derivative.

        point: also draw the tangent line at x=point
        kwargs: forwarded to differentiate() when method='smooth'
        '''
        x_smooth = np.linspace(a, b, 500)
        y_smooth = self.f(x_smooth)
        dfx, X = self.differentiate(a, b, n, method=method, **kwargs)

        fig, ax1 = plt.subplots(figsize=figsize)
        ax1.plot(x_smooth, y_smooth, 'b-', label='f(x)')
        ax1.set_xlabel('x')
        ax1.set_ylabel('f(x)', color='b')
        ax1.tick_params(axis='y', labelcolor='b')

        ax2 = ax1.twinx()
        ax2.plot(X, dfx, 'r--', label=f"f'(x) [{method}]")
        ax2.set_ylabel("f'(x)", color='r')
        ax2.tick_params(axis='y', labelcolor='r')

        lines1, labels1 = ax1.get_legend_handles_labels()
        lines2, labels2 = ax2.get_legend_handles_labels()

        if point is not None:
            slope, tx, ty = self.tangent_line(point, span=(b - a) * 0.2)
            ax1.plot(tx, ty, 'g-', linewidth=2,
                     label=f'Tangent at x={point} (slope={slope:.4f})')
            ax1.plot(point, self.f(point), 'go', markersize=8)
            lines1, labels1 = ax1.get_legend_handles_labels()

        ax1.legend(lines1 + lines2, labels1 + labels2, loc='best')
        plt.title(f'f(x) and its derivative ({method} difference)')
        plt.tight_layout()
        plt.show()


if __name__ == '__main__':

    # ------------------------------------------------------------------
    # Differentiation demo: f(x) = sin(x), exact derivative = cos(x)
    # ------------------------------------------------------------------
    di = Differentiation(lambda x: np.sin(x))

    print('\n--- Differentiation: max error vs exact cos(x) ---')
    for m in ('forward', 'backward', 'central'):
        dfx, X = di.differentiate(0, 2 * np.pi, 100, method=m)
        print(f"{m:>8}: {max(abs(np.cos(X) - dfx)):.6f}")
        di.plot(0, 2 * np.pi, n=100, method=m)

    dfx, X = di.differentiate(0, 2 * np.pi, 200, method='smooth', noise_std=0.02)
    print(f"{'smooth':>8}: {max(abs(np.cos(X) - dfx)):.6f}")
    di.plot(0, 2 * np.pi, n=200, method='smooth', noise_std=0.02)

    # tangent line demo (central diff)
    di.plot(0, 2 * np.pi, n=100, method='central', point=np.pi / 4)
