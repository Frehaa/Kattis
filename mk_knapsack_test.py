import random as r

c = int(input())
n = int(input())

print c, n

for _ in range(n):
    v = r.randint(1, 10000)
    w = r.randint(1, 10000)
    print v, w
