#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
@author: danielmartens

Interpolation: a small class wrapping several interpolation methods behind one
interface. Build it from data points (x, y), then call a method with the query
points X:

  - Linear_Interp   piecewise-linear
  - Cubic_Spline    cubic spline with 'natural' or 'clamped' end conditions
  - nearest_neighbor
  - Newton_poly     Newton's divided-difference polynomial
  - Lagrange_poly   Lagrange polynomial

x is sorted on construction (y is reordered to match). Each method returns a
dict with the sorted query points 'X', the interpolated values 'Y', the
'method' name, and a 'func' callable, all of which plot_interpolation() uses.
Newton_poly and Lagrange_poly require unique x values and extrapolate (with a
warning) outside the range of x; the other methods raise ValueError instead.
"""

import warnings

import numpy as np
import matplotlib.pyplot as plt
from numpy.linalg import inv


class Interpolation:

    def __init__(self, x, y):

        x = np.asarray(x, dtype=float)
        y = np.asarray(y, dtype=float)

        if len(x) != len(y):
            raise ValueError('x and y must be arrays with the same length')

        idx = np.argsort(x)
        self.x = x[idx]
        self.y = y[idx]

    def _check_X(self, X, allow_extrapolation=False):

        X = np.asarray(X, dtype=float)

        if not allow_extrapolation and (X.min() < self.x.min() or X.max() > self.x.max()):
            raise ValueError('X must be bounded within x')

        return np.sort(X)

    def Linear_Interp(self, X):

        x, y = self.x, self.y
        X = self._check_X(X)

        Y = []

        for i in range(len(X)):
            for j in range(len(x) - 1):

                if X[i] >= x[j] and X[i] < x[j + 1]:

                    y_hat = y[j] + ((y[j + 1] - y[j]) / (x[j + 1] - x[j])) * (X[i] - x[j])
                    Y.append(y_hat)
                    break

            else:
                if X[i] == x[-1]:
                    Y.append(y[-1])

        return {'X': X, 'Y': np.array(Y), 'method': 'Linear Interpolation',
                'func': lambda Xq: self.Linear_Interp(Xq)['Y']}

    def Cubic_Spline(self, X, bc_type='natural', D1=0, Dn=0):

        x, y = self.x, self.y
        X = self._check_X(X)

        if bc_type != 'natural' and bc_type != 'clamped':
            raise ValueError('bc_type must be "natural" or "clamped".')

        num_S = len(x) - 1
        n = 4 * num_S
        A = np.zeros((n, n))
        b = np.zeros(n)

        # ── Constraints 1 & 2: S_i(x_i) = y_i and S_i(x_{i+1}) = y_{i+1} ──
        row = 0
        for i in range(num_S):
            col = 4 * i
            A[row, col:col + 4] = [x[i] ** 3, x[i] ** 2, x[i], 1]
            b[row] = y[i]
            row += 1

        for i in range(num_S):
            col = 4 * i
            A[row, col:col + 4] = [x[i + 1] ** 3, x[i + 1] ** 2, x[i + 1], 1]
            b[row] = y[i + 1]
            row += 1

        # ── Constraint 3: S_i'(x_{i+1}) = S_{i+1}'(x_{i+1}) ──
        for i in range(num_S - 1):
            col = 4 * i
            A[row, col:col + 4] = [3 * x[i + 1] ** 2, 2 * x[i + 1], 1, 0]
            A[row, col + 4:col + 8] = [-3 * x[i + 1] ** 2, -2 * x[i + 1], -1, 0]
            b[row] = 0
            row += 1

        # ── Constraint 4: S_i''(x_{i+1}) = S_{i+1}''(x_{i+1}) ──
        for i in range(num_S - 1):
            col = 4 * i
            A[row, col:col + 4] = [6 * x[i + 1], 2, 0, 0]
            A[row, col + 4:col + 8] = [-6 * x[i + 1], -2, 0, 0]
            b[row] = 0
            row += 1

        col = 4 * (num_S - 1)

        if bc_type == 'natural':
            A[row, 0:4] = [6 * x[0], 2, 0, 0]
            b[row] = 0
            row += 1

            A[row, col:col + 4] = [6 * x[-1], 2, 0, 0]
            b[row] = 0

        if bc_type == 'clamped':
            A[row, 0:4] = [3 * x[0] ** 2, 2 * x[0], 1, 0]
            b[row] = D1
            row += 1

            A[row, col:col + 4] = [3 * x[-1] ** 2, 2 * x[-1], 1, 0]
            b[row] = Dn

        # ── Solve ──
        coeff = np.dot(inv(A), b).reshape(num_S, 4)

        # ── Vectorized interpolation ──
        intervals = np.searchsorted(x, X, side='right') - 1
        intervals = np.clip(intervals, 0, num_S - 1)   # handles X == x[-1]

        a  = coeff[intervals, 0]
        b_ = coeff[intervals, 1]
        c  = coeff[intervals, 2]
        d  = coeff[intervals, 3]

        Y = ((a * X + b_) * X + c) * X + d   # Horner's method — no loop needed


        return {'X': X, 'Y': Y, 'method': f'Cubic Spline ({bc_type})',
                'func': lambda Xq, bc_type=bc_type, D1=D1, Dn=Dn:
                    self.Cubic_Spline(Xq, bc_type=bc_type, D1=D1, Dn=Dn)['Y']}

    def nearest_neighbor(self, X):

        x, y = self.x, self.y
        X = self._check_X(X)

        Y = []

        for n in range(len(X)):
            idx = np.argmin(np.abs(x - X[n]))
            Y.append(y[idx])

        return {'X': X, 'Y': np.array(Y), 'method': 'Nearest Neighbor',
                'func': lambda Xq: self.nearest_neighbor(Xq)['Y']}

    def Newton_poly(self, X):

        x, y = self.x, self.y

        X = np.asarray(X, dtype=float)

        if len(np.unique(x)) != len(x):
            raise ValueError('x must contain unique values')

        if X.min() < x.min() or X.max() > x.max():
            warnings.warn("X is outside the range of x — extrapolating!")

        X = np.sort(X)

        n = len(y)

        coeff = np.zeros((n, n))
        coeff[:, 0] = y.T

        for j in range(1, n):
            for i in range(n - j):
                coeff[i, j] = (coeff[i + 1, j - 1] - coeff[i, j - 1]) / (x[i + j] - x[i])

        c = coeff[0, :]

        m = n - 1
        p = c[m]
        for k in range(1, m + 1):
            p = c[m - k] + (X - x[m - k]) * p

        return {'X': X, 'Y': np.asarray(p), 'method': "Newton's Divided-Difference Polynomial",
                'func': lambda Xq: self.Newton_poly(Xq)['Y']}

    def Lagrange_poly(self, X):

        x, y = self.x, self.y

        X = np.asarray(X, dtype=float)

        if len(np.unique(x)) != len(x):
            raise ValueError('x must contain unique values')

        if X.min() < x.min() or X.max() > x.max():
            warnings.warn("X is outside the range of x — extrapolating!")

        X = np.sort(X)

        n = len(x)
        
        # difference matrix
        # X -> column vector, x -> row vector
        # diff[k, i] = X[k] - x[i]  →  shape (m, n)
        diff = X[:, None] - x[None, :]

        # Denominator: x[j] - x[i] for all i≠j  →  shape (n,)
        denom_mat = x[:, None] - x[None, :]   # (n, n)
        np.fill_diagonal(denom_mat, 1.0)       # avoid divide-by-zero on diagonal
        denom = np.prod(denom_mat, axis=1)     # (n,)

        # Numerator: for each basis j, product of (X[k] - x[i]) for i≠j
        # Broadcast diff to (m, n, n), zero out i==j positions by setting them to 1
        mask = ~np.eye(n, dtype=bool)                              # (n, n)
        diff_3d = np.where(mask[None, :, :], diff[:, None, :], 1.0)  # (m, n, n)
        numer = np.prod(diff_3d, axis=2)                           # (m, n)

        # Lagrange basis values: basis[k, j] = L_j(X[k])
        basis = numer / denom[None, :]   # (m, n)

        Y = basis @ y   # (m,)

        return {'X': X, 'Y': Y, 'method': 'Lagrange Polynomial',
                'func': lambda Xq: self.Lagrange_poly(Xq)['Y']}

    def plot_interpolation(self, interpolated_output, ax=None, n_dense=300):

        X = interpolated_output['X']
        Y = interpolated_output['Y']
        method = interpolated_output.get('method', 'Interpolation')
        func = interpolated_output.get('func')

        # only create the figure and call plt.show() when the caller didn't
        # supply an axis, so this can be used to fill subplots
        standalone = ax is None
        if standalone:
            fig, ax = plt.subplots()

        if func is not None:
            lo = min(self.x.min(), X.min())
            hi = max(self.x.max(), X.max())
            X_dense = np.linspace(lo, hi, n_dense)

            with warnings.catch_warnings():
                warnings.simplefilter('ignore')
                Y_dense = func(X_dense)

            ax.plot(X_dense, Y_dense, '-', color='#2a78d6', linewidth=2,
                    zorder=2, label=method)
        else:
            ax.plot(X, Y, '-', color='#2a78d6', linewidth=2, zorder=2, label=method)

        ax.scatter(self.x, self.y, s=64, color='#0b0b0b', zorder=3,
                   label='Data', edgecolors='none')
        ax.scatter(X, Y, s=64, color='#eb6834', zorder=4,
                   label='Interpolated points', edgecolors='white', linewidths=1)

        ax.set_xlabel('x')
        ax.set_ylabel('y')
        ax.set_title(method)
        ax.set_axisbelow(True)
        ax.grid(True, color='#e1e0d9', linewidth=0.8, zorder=0)
        for spine in ('top', 'right'):
            ax.spines[spine].set_visible(False)
        for spine in ('left', 'bottom'):
            ax.spines[spine].set_color('#c3c2b7')
        ax.tick_params(colors='#52514e')
        ax.legend(frameon=False)

        if standalone:
            plt.show()

        return ax


if __name__ == '__main__':

    x = np.array([0, 1, 2, 3, 4, 5])
    y = np.array([2, 4, 3, 4, 7, 1])
    X = np.array([0.5, 1.5, 2.25, 2.75, 3.3, 4.6])

    instance = Interpolation(x, y)

    Y_linear = instance.Linear_Interp(X)
    instance.plot_interpolation(Y_linear)

    Y_cubic = instance.Cubic_Spline(X)
    instance.plot_interpolation(Y_cubic)

    Y_newton = instance.Newton_poly(X)
    instance.plot_interpolation(Y_newton)

    Y_lagrange = instance.Lagrange_poly(X)
    instance.plot_interpolation(Y_lagrange)
