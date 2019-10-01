import sys
import math

lines = []

for line in sys.stdin:
    lines.append(line)

l, d, n = lines[0].split()

l, d, n = int(l), int(d), int(n)

def between(a, b, d):
    if (b - a) < 0: return 0
    return ((b - a) // d) + 1

birds = []

for i in range(n):
    b = int(lines[i + 1])
    birds.append(b)

birds.sort()

# Counting birds between each other
count = 0 
for i in range(len(birds) - 1):
    a = birds[i] + d
    b = birds[i + 1] - d
    count += between(a, b, d)

if len(birds) > 0: 
    # Counting birds at ends
    a = 6
    b = birds[0] - d
    count += between(a, b, d)

    a = birds[-1] + d
    b = l - 6
    count += between(a, b, d)
else:
    a = 6
    b = l - 6
    count += between(a, b, d)

print (count)
