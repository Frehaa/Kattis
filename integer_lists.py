import sys
import json

lines = sys.stdin.readlines()

results = []
for i in xrange(1, len(lines), 3):
    program = lines[i]
    elems = json.loads(lines[i+2])
    forward = True
    s, e = 0, len(elems)

    for c in program.strip():
        if c == "R":
            forward = not forward
        elif c == "D":
            if forward: s += 1
            else: e -= 1

    if s <= e: 
        if not forward:
            elems = list(reversed(elems[s:e]))
        results.append("[" + ','.join(map(str,elems[s:e])) + "]")
    else:
        results.append("error")

print ('\n'.join(results))
