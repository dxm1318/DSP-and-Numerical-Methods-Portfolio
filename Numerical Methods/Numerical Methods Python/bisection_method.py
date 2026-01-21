import math

def f(x):
    return 4 - x*math.log(x)

tol = 5e-7

while True:
    a=float(input("What is the left guess for the root?"))   
    b=float(input("What is the right guess for the root?"))
    
    if a<= 0 or b<= 0:
        print("Both guesses must be greater than 0 (log domain).")
    

    if f(a)*f(b)>0:
        print("There no zero within your interval, please reinput your " \
              "values.")
        continue
    break
        
# Bisection Method

while abs(b-a)>tol*max(1,abs(b)):
    c = (a+b)/2
    if abs(f(c)) < tol:
        break
    elif f(a) * f(c) < 0:
        b = c
    else:
        a = c
    
root = (a+b)/2

print("The root is approximately:" , root)
    


