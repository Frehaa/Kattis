import sys

lines = sys.stdin.readlines()

sum = 0

for line in lines[1:]:
    line = line.strip()
    pow = int(line[-1])
    n = int(line[0:-1])

    sum += n**pow
print(sum)
