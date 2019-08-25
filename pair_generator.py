from random import randint
import sys

n = randint(1, 10000)
t = randint(1, 47)

print n, t

for _ in range(n):
    c = randint(1, 100000)
    w = randint(0, t)
    print c, w
