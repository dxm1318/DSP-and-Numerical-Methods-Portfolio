#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Apr 28 23:16:45 2023

@author: danielmartens
"""

import math


def F(t, x):
    """
    Right-hand side of the ODE system:
        x0' = 2 - t/4 - (3/2)x0 - 2x1
        x1' = 1 + t/2 - 4x1
    """
    dx0 = 2.0 - t/4.0 - 1.5*x[0] - 2.0*x[1]
    dx1 = 1.0 + t/2.0 - 4.0*x[1]
    return [dx0, dx1]


def rk4_step(F, t, x, h):
    """
    One step of classical 4th-order Runge–Kutta
    for an n-dimensional system.
    """
    n = len(x)

    K1 = F(t, x)
    K2 = F(t + h/2.0, [x[i] + h*K1[i]/2.0 for i in range(n)])
    K3 = F(t + h/2.0, [x[i] + h*K2[i]/2.0 for i in range(n)])
    K4 = F(t + h,     [x[i] + h*K3[i]     for i in range(n)])

    return [
        x[i] + h*(K1[i] + 2*K2[i] + 2*K3[i] + K4[i]) / 6.0
        for i in range(n)
    ]


# Time integration


t0 = 0.0
tf = 3.0
nsteps = 5000
h = (tf - t0) / nsteps

t = t0
X = [136.0/36.0, 53.0/12.0]   # initial condition

with open("degree2-3_1_RK4_system.dat", "w") as file:
    file.write("{:.8f} {:.8f} {:.8f}\n".format(t, X[0], X[1]))

    for k in range(nsteps):
        X = rk4_step(F, t, X, h)
        t += h
        file.write("{:.8f} {:.8f} {:.8f}\n".format(t, X[0], X[1]))
