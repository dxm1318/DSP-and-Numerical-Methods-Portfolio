import math


def f(x):
    return x**3 * math.sin(math.log(x*x + 1))


def central_diff(x, h):
    return (f(x + h) - f(x - h)) / (2.0 * h)


x = 169.0
h = 1.0
N = 11
TOL = 1e-12

D_prev = [central_diff(x, h)]
print(D_prev[0], "\n")

converged = False

for i in range(1, N):
    h /= 2.0
    D_curr = [central_diff(x, h)]
    print(D_curr[0])

    for j in range(1, i + 1):
        factor = 4**j
        D_curr.append(
            (factor * D_curr[j - 1] - D_prev[j - 1]) / (factor - 1)
        )
        print(D_curr[j])

        if abs(D_curr[j] - D_prev[j - 1]) < TOL * abs(D_curr[j]):
            print("\nConverged derivative:", D_curr[j])
            converged = True
            break

    print()
    if converged:
        break

    D_prev = D_curr[:]

if not converged:
    print("\nBest approximation:", D_prev[-1])
