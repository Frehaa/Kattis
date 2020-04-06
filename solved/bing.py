import sys
from collections import defaultdict

lines = sys.stdin.readlines()

seen = defaultdict(int)

results = []

for w in lines[1:]:
    w = w.strip()
    results.append(str(seen[w]))
    for i in range(len(w)):
        substr = w[0:i+1]
        seen[substr] += 1
print("\n".join(results))
