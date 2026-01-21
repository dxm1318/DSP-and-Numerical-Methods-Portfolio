import math

def f(x):
    return x*x*math.log(2*x+5)

def basicGauss(a,b):
    d = (b-a)/2
    sr3 = 1/math.sqrt(3)
    return d*(f(d*(-sr3-1)+b)+f(d*(sr3-1)+b))

def adaptiveGauss(estimate1,a,b,level,maxlevel,tol):
    level += 1
    if level > maxlevel:
        raise RuntimeError("integration failed")
    
    midpoint = (a+b)/2.
    estimate2L = basicGauss(a,midpoint)
    estimate2R = basicGauss(midpoint,b)
    estimate2 = estimate2L + estimate2R

    if abs(estimate1-estimate2)<tol*abs(estimate1) or abs(estimate1-estimate2)<tol:
        return estimate2
    return (
        adaptiveGauss(estimate2L, a, midpoint, level+1, maxlevel, tol) +
        adaptiveGauss(estimate2R, midpoint, b, level+1, maxlevel, tol)
        )
        

def integrate(a,b):
    return adaptiveGauss(basicGauss(a,b),a,b,0,50,1e-12)

print(integrate(-2,7))
