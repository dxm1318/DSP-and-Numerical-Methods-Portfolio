#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Sep 1 2026

@author: danielmartens

FindRoot: a small class wrapping the bisection, Newton-Raphson, and secant
root-finding methods behind one interface.

ch19+exercises.py has both a recursive and an iterative implementation of
each method (bisection_recursive vs. my_bisection_method,
newton_raph_recursive vs. the loop in newton_raph_sym, secant_recursive vs.
secant_method). This class uses the ITERATIVE version of each, because:

  - Python has no tail-call optimization, so every recursive call keeps its
    own stack frame. That makes recursion slower per step than a loop, which
    just rebinds a few local variables and reuses one frame.
  - Deep recursion risks RecursionError on slowly-converging problems or
    tight tolerances, even with sys.setrecursionlimit() raised (as
    ch19+exercises.py does). An iterative while/for loop has no such ceiling
    and uses O(1) memory regardless of how many steps it takes.
  - Both forms apply the exact same update formula at each step (bisection's
    midpoint rule, Newton's x - f(x)/f'(x), the secant formula), so there is
    no accuracy difference between them -- the iterative version is strictly
    more efficient with no numerical tradeoff.
"""

import numbers

import numpy as np
import matplotlib.pyplot as plt
from sympy import Expr, diff, lambdify


class FindRoot:

    METHODS = ['bisection', 'newton', 'secant']

    def __init__(self, f):
        self.f = f
        self.df = None       # populated automatically for symbolic f
        self.history = []    # iterates from the most recent solve, for plot()
        self._validate()

    # ------------------------------------------------------------------
    # Validation (done once here, rather than repeated on every
    # iteration/recursive call -- the same lesson ch19+exercises.py draws
    # in its bisection_validation / bisection_recursive split)
    # ------------------------------------------------------------------

    def _validate(self):

        if not (callable(self.f) or isinstance(self.f, Expr)):
            raise TypeError('f must be a callable or symbolic function')

        if isinstance(self.f, Expr):
            free_syms = list(self.f.free_symbols)
            if len(free_syms) != 1:
                raise ValueError('symbolic function must have exactly one free variable')
            t = free_syms[0]
            df_sym = diff(self.f, t, 1)
            self.f = lambdify(t, self.f, 'numpy')
            self.df = lambdify(t, df_sym, 'numpy')

        print(f"Available root-finding methods: {', '.join(self.METHODS)}")

    @staticmethod
    def _validate_tol_iter(tol, max_iter):
        if not isinstance(tol, numbers.Real) or tol <= 0:
            raise ValueError('tol must be a positive float or int')
        if not isinstance(max_iter, numbers.Integral) or max_iter < 1:
            raise ValueError('max_iter must be a positive integer')

    def _numeric_derivative(self, x, h=1e-6):
        '''central-difference derivative, used when f has no closed-form df'''
        return (self.f(x + h) - self.f(x - h)) / (2 * h)

    # ------------------------------------------------------------------
    # Bisection
    # ------------------------------------------------------------------

    def bisection(self, a, b, tol=1e-10, max_iter=5000):
        '''Bracketed bisection method.

        a, b -> interval such that f(a) and f(b) have opposite signs
        returns the approximate root
        '''
        if not (isinstance(a, numbers.Real) and isinstance(b, numbers.Real)):
            raise TypeError('a and b must be a float or int')
        if a >= b:
            raise ValueError('a must be less than b')
        self._validate_tol_iter(tol, max_iter)

        fa, fb = self.f(a), self.f(b)
        if np.sign(fa) == np.sign(fb):
            raise ValueError('f(a) and f(b) must have opposite signs')

        m = (a + b) / 2
        fm = self.f(m)
        history = [m]

        for _ in range(max_iter):
            if np.abs(fm) < tol:
                break
            if np.sign(fm) == np.sign(fa):
                a, fa = m, fm       # root is in [m, b]
            else:
                b, fb = m, fm       # root is in [a, m]
            m = (a + b) / 2
            fm = self.f(m)
            history.append(m)

        self.history = history
        return m

    # ------------------------------------------------------------------
    # Newton-Raphson
    # ------------------------------------------------------------------

    def newton(self, x0, tol=1e-10, max_iter=5000, fprime=None):
        '''Newton-Raphson method starting from x0.

        fprime is optional if this instance was built from a symbolic
        expression (its derivative is already known); otherwise a
        central-difference derivative is used unless fprime is supplied.
        '''
        if not isinstance(x0, numbers.Real):
            raise TypeError('x0 must be an int or float')
        self._validate_tol_iter(tol, max_iter)

        df = fprime or self.df or self._numeric_derivative

        x_prev = x0
        history = [x0]

        for _ in range(max_iter):
            fx = self.f(x_prev)
            if np.abs(fx) < tol:
                self.history = history
                return x_prev

            dfx = df(x_prev)
            if np.abs(dfx) < 1e-12 or np.isinf(dfx) or np.isnan(dfx):
                raise ZeroDivisionError(
                    "derivative at x is near zero, infinite, or NaN; "
                    "Newton-Raphson failed to converge"
                )

            try:
                x_next = x_prev - fx / dfx
            except OverflowError:
                raise ZeroDivisionError('numerical overflow in Newton-Raphson update')

            history.append(x_next)
            if np.abs(x_next - x_prev) < tol:
                self.history = history
                return x_next

            x_prev = x_next

        self.history = history
        return x_prev

    # ------------------------------------------------------------------
    # Secant
    # ------------------------------------------------------------------

    def secant(self, x0, x1, tol=1e-10, max_iter=5000):
        '''Secant method using two initial guesses x0, x1 (no derivative
        required).'''

        if not (isinstance(x0, numbers.Real) and isinstance(x1, numbers.Real)):
            raise TypeError('x0 and x1 must be a float or int')
        self._validate_tol_iter(tol, max_iter)

        fx0 = self.f(x0)
        history = [x0, x1]

        for _ in range(max_iter):
            fx1 = self.f(x1)
            if np.abs(fx1 - fx0) < 1e-12:
                break

            x2 = x1 - fx1 * (x1 - x0) / (fx1 - fx0)
            history.append(x2)

            if np.abs(x2 - x1) < tol:
                self.history = history
                return x2

            x0, fx0 = x1, fx1
            x1 = x2

        self.history = history
        return x1

    # ------------------------------------------------------------------
    # Plotting
    # ------------------------------------------------------------------

    def plot(self, a, b, root=None, method=None, figsize=(10, 6), n=500):
        '''Plot f(x) over [a, b], marking the root and the path of iterates
        from the most recent bisection/newton/secant call.'''

        x = np.linspace(a, b, n)
        y = self.f(x)

        fig, ax = plt.subplots(figsize=figsize)
        ax.axhline(0, color='gray', linewidth=0.8)
        ax.plot(x, y, 'b-', label='f(x)')

        ax.plot(a, 0, marker='^', color='k', markersize=9, linestyle='None',
                 clip_on=False, zorder=5, label=f'a = {a}')
        ax.plot(b, 0, marker='v', color='k', markersize=9, linestyle='None',
                 clip_on=False, zorder=5, label=f'b = {b}')

        if self.history:
            hx = np.array(self.history, dtype=float)
            ax.plot(hx, self.f(hx), 'o--', color='orange', markersize=4,
                     label=f'iterates ({method})' if method else 'iterates')

        if root is not None:
            ax.plot(root, self.f(root), 'r*', markersize=14,
                     label=f'root = {root:.6f}')

        ax.set_xlabel('x')
        ax.set_ylabel('f(x)')
        ax.set_title('Root Finding' + (f': {method}' if method else ''))
        ax.legend()
        plt.show()


if __name__ == '__main__':

    # ------------------------------------------------------------------
    # Bisection demo: f(x) = x**2 - 2, root = sqrt(2)
    # ------------------------------------------------------------------
    fr = FindRoot(lambda x: x**2 - 2)

    root_b = fr.bisection(0, 2, tol=1e-10)
    print(f"\nBisection root:  {root_b:.10f}  (sqrt(2) = {np.sqrt(2):.10f})")
    fr.plot(0, 2, root=root_b, method='bisection')

    # ------------------------------------------------------------------
    # Newton-Raphson demo: same f, with an explicit derivative
    # ------------------------------------------------------------------
    fr_newton = FindRoot(lambda x: x**2 - 2)
    root_n = fr_newton.newton(1.5, tol=1e-10, fprime=lambda x: 2 * x)
    print(f"Newton root:     {root_n:.10f}  (sqrt(2) = {np.sqrt(2):.10f})")
    fr_newton.plot(0, 2, root=root_n, method='newton')

    # ------------------------------------------------------------------
    # Secant demo: same f, no derivative needed
    # ------------------------------------------------------------------
    fr_secant = FindRoot(lambda x: x**2 - 2)
    root_s = fr_secant.secant(1.0, 2.0, tol=1e-10)
    print(f"Secant root:     {root_s:.10f}  (sqrt(2) = {np.sqrt(2):.10f})")
    fr_secant.plot(0, 2, root=root_s, method='secant')

    # ------------------------------------------------------------------
    # Symbolic input demo: f(x) = x**3 - 8x - 3, Newton auto-differentiates
    # ------------------------------------------------------------------
    from sympy import symbols
    t = symbols('t')
    fr_sym = FindRoot(t**3 - 8 * t - 3)
    root_sym = fr_sym.newton(3.5, tol=1e-10)
    print(f"\nSymbolic Newton root of t**3 - 8t - 3: {root_sym:.10f}")
    print(f"f(root) = {fr_sym.f(root_sym):.2e}")
    fr_sym.plot(-4, 4, root=root_sym, method='newton')
