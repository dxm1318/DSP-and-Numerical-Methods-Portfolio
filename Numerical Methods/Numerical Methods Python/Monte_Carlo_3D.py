#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Apr 23 17:17:59 2023

@author: danielmartens
"""

import math
import random

def f(x,y,z):
    return y*x*x+z*math.log(y)+math.exp(x)

random.seed()
total=0
volume = 12
N = 100

for i in range(10):
    for j in range(N):
        x = 2*random.random()-1 # [-1,1]
        y = 3*random.random()+3 # [3,6] 
        z = 2*random.random()   # [0,2]
        total += f(x,y,z)
    N = (i+1) * N
    estimate = volume *total/N
    print(estimate)