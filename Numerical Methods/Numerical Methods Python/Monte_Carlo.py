#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Apr  3 21:14:15 2023

@author: danielmartens
"""

import math
import random

def f(x,y): 
    #return x*y
    return x*y

def in_region(x,y):
    return (x>= 1/9) and (y>= math.sqrt(x)) and (3*x <= 9-y)



#Estimate area

N = 1000
area = 0

for i in range(10):
    for j in range(100000):
        x = 3*random.random()
        y = 3*random.random()
        if in_region(x,y):
            area += 1
    
    area_est = 9.0 * area / ((i+1*N))
    print("Area estimate:", area_est)
    
    
    
A = area_est


#Estimate Integral

total = 0.0
samples = 0
for i in range(10):
    j=0
    while j < N:
        x = 3*random.random()
        y = 3*random.random()
        if in_region(x,y):           
            total += f(x,y)
            j += 1
            samples += 1
    integral_est = A*total/samples
    print("Integral estimate:", integral_est)