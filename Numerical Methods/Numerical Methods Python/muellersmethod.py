#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Feb  1 15:24:40 2023

@author: danielmartens
"""

import cmath



# Polynomial and derivative


def poly(coeffs, x):
    """
    Evaluate polynomial using Horner's method.
    coeffs: [a0, a1, ..., an] with a0 = constant term
    """
    p = 0.0
    for c in reversed(coeffs):
        p = p * x + c
    return p


def poly_derivative(coeffs, x):
    """
    Evaluate derivative using Horner's method.
    """
    n = len(coeffs) - 1
    p = 0.0
    for c in reversed(coeffs[1:]):
        p = p * x + n * c
        n -= 1
    return p



# Input


degree = int(input("Degree of the polynomial: "))

coefficients = []
for k in range(degree + 1):
    c = float(input(f"Coefficient of x^{k}: "))
    coefficients.append(c)

x1 = float(input("Initial guess: "))



# Newton steps (startup)


x2 = x1 - poly(coefficients, x1) / poly_derivative(coefficients, x1)
x3 = x2 - poly(coefficients, x2) / poly_derivative(coefficients, x2)



# Müller's method


TOL = 1e-12
MAXITER = 1000

counter = 0

while counter < MAXITER:
    f1 = poly(coefficients, x1)
    f2 = poly(coefficients, x2)
    f3 = poly(coefficients, x3)

    h1 = x2 - x1
    h2 = x3 - x2

    if abs(h2) < TOL * abs(x3):
        break

    d1 = (f2 - f1) / h1
    d2 = (f3 - f2) / h2

    A = (d2 - d1) / (h2 + h1)
    B = d2 + A * h2
    C = f3

    D = cmath.sqrt(B**2 - 4*A*C)

    if abs(B + D) > abs(B - D):
        denom = B + D
    else:
        denom = B - D

    h = -2 * C / denom

    # shift points
    x1, x2 = x2, x3
    x3 = x3 + h

    counter += 1



# Output


if counter == MAXITER:
    print("Root not found.")
    print("Last approximation:", x3)
else:
    print(f"Root found after {counter} iterations:")
    print("x =", x3)
