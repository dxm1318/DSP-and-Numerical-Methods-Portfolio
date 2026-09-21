#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Sep 1 2026

@author: danielmartens

Integration: a small class containing the numerical integration methods
(left/right/midpoint Riemann sums, trapezoidal rule, Simpson's rule, and Monte
Carlo) behind one interface.

Split out of the former differentiation_integration.py; the differentiation
methods now live in differentiation.py.
"""

import numbers

import numpy as np
import matplotlib.pyplot as plt
from sympy import Expr, lambdify


class Integration:

    METHODS = ['left', 'right', 'midpoint', 'trapezoidal', 'simpsons', 'monte_carlo']

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

        print(f"Available integration methods: {', '.join(self.METHODS)}")

    def _eval(self, x):
        '''evaluate f at x, broadcast to the shape of x, so that an f that
        returns a single number (e.g. lambda x: 5) still works as a function
        of an array instead of being summed as one sample'''
        return np.broadcast_to(np.asarray(self.f(x)), np.shape(x))

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
    # Integration
    # ------------------------------------------------------------------

    def integrate(self, a, b, n, method='trapezoidal'):
        '''Numerically integrate f over [a, b] using n points.

        method: 'left', 'right', 'midpoint', 'trapezoidal', 'simpsons' (n must
        be odd), or 'monte_carlo' (n = number of random samples)
        returns the approximate area
        '''
        method = method.lower()
        if method not in self.METHODS:
            raise ValueError(f"method must be one of {self.METHODS}")

        self._validate_bounds(a, b, n)

        if method == 'left':
            return self._left_riemann(a, b, n)
        elif method == 'right':
            return self._right_riemann(a, b, n)
        elif method == 'midpoint':
            return self._midpoint_riemann(a, b, n)
        elif method == 'trapezoidal':
            return self._trapezoidal(a, b, n)
        elif method == 'simpsons':
            return self._simpsons(a, b, n)
        else:
            return self._monte_carlo(a, b, n)

    def _left_riemann(self, a, b, n):
        h = (b - a) / (n - 1)
        x = np.linspace(a, b, n)
        return h * np.sum(self._eval(x[:-1]))

    def _right_riemann(self, a, b, n):
        h = (b - a) / (n - 1)
        x = np.linspace(a, b, n)
        return h * np.sum(self._eval(x[1:]))

    def _midpoint_riemann(self, a, b, n):
        h = (b - a) / (n - 1)
        x = np.linspace(a, b, n)
        y = (x[1:] + x[:-1]) / 2
        return h * np.sum(self._eval(y))

    def _trapezoidal(self, a, b, n):
        h = (b - a) / (n - 1)
        x = np.linspace(a, b, n)
        return (h / 2) * (self._eval(x[0]) + 2 * np.sum(self._eval(x[1:-1])) + self._eval(x[-1]))

    def _simpsons(self, a, b, n):
        if n % 2 == 0:
            raise ValueError('n must be odd for Simpsons rule')
        h = (b - a) / (n - 1)
        x = np.linspace(a, b, n)
        return (h / 3) * (self._eval(x[0]) + 4 * np.sum(self._eval(x[1:-1:2]))
                           + 2 * np.sum(self._eval(x[2:-2:2])) + self._eval(x[-1]))

    def _monte_carlo(self, a, b, n):
        '''mean-value Monte Carlo estimate: average f at n random points in [a, b]'''
        x = np.sort(np.random.uniform(a, b, n))
        return ((b - a) / n) * np.sum(self._eval(x))

    # ------------------------------------------------------------------
    # Plotting
    # ------------------------------------------------------------------

    def plot(self, a, b, n=100, method='trapezoidal', figsize=(10, 6)):
        '''Plot f with the subintervals used by the chosen integration method
        and the resulting approximate area.'''

        method = method.lower()
        x_smooth = np.linspace(a, b, 500)
        y_smooth = self._eval(x_smooth)
        x = np.linspace(a, b, n)
        y = self._eval(x)

        if method == 'monte_carlo':
            x_mc = np.sort(np.random.uniform(a, b, n))
            y_mc = self._eval(x_mc)
            area = ((b - a) / n) * np.sum(y_mc)
        else:
            area = self.integrate(a, b, n, method=method)

        fig, ax = plt.subplots(figsize=figsize)
        ax.plot(x_smooth, y_smooth, 'b-', label='f(x)')

        if method in ('left', 'right', 'midpoint'):
            h = (b - a) / (n - 1)
            if method == 'left':
                heights = y[:-1]
            elif method == 'right':
                heights = y[1:]
            else:
                mids = (x[1:] + x[:-1]) / 2
                heights = self._eval(mids)
                ax.plot(mids, heights, 'ko', markersize=3)
            ax.bar(x[:-1], heights, width=h, align='edge', alpha=0.4,
                   edgecolor='black', color='orange', label='subintervals')
            title = f'{method.capitalize()} Riemann Sum'

        elif method == 'trapezoidal':
            ax.fill_between(x, y, alpha=0.4, color='orange', label='subintervals')
            ax.plot(x, y, 'ko-', markersize=3)
            title = 'Trapezoidal Rule'

        elif method == 'simpsons':
            for i in range(0, n - 2, 2):
                xi, yi = x[i:i + 3], y[i:i + 3]
                coeffs = np.polyfit(xi, yi, 2)
                xf = np.linspace(xi[0], xi[-1], 30)
                yf = np.polyval(coeffs, xf)
                ax.fill_between(xf, yf, alpha=0.4, color='orange',
                                 label='subintervals' if i == 0 else None)
            ax.plot(x, y, 'ko', markersize=3)
            title = "Simpson's Rule"

        else:  # monte_carlo
            ax.fill_between(x_smooth, y_smooth, alpha=0.2, color='orange',
                             label='area under f(x)')
            ax.scatter(x_mc, y_mc, color='black', s=15, zorder=3,
                       label=f'{n} random samples')
            title = 'Monte Carlo Integration'

        ax.set_xlabel('x')
        ax.set_ylabel('y')
        ax.set_title(f'{title} (n={n}), Approx. Area = {area:.4f}')
        ax.legend()
        plt.show()


if __name__ == '__main__':

    # ------------------------------------------------------------------
    # Integration demo: f(x) = sin(x) on [0, pi], exact area = 2
    # ------------------------------------------------------------------
    ig = Integration(lambda x: np.sin(x))

    print('\n--- Integration: approximate area (exact = 2.0) ---')
    for m in ig.METHODS:
        area = ig.integrate(0, np.pi, 101, method=m)
        print(f"{m:>11}: {area:.6f}")
        ig.plot(0, np.pi, n=11, method=m)
