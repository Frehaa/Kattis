import sys, os

line = raw_input()

sites, ops = line.split()

id = [i for i in range(int(sites))]
sz = [1 for _ in range(int(sites))]

def find(p):
    while p != id[p]: p = id[p]
    return p

results = []

for _ in range(int(ops)):
    line = raw_input()
    op, p, q = line.split()

    p_root = find(int(p))
    q_root = find(int(q))

    if op == "=": 
        if p_root == q_root:
            continue

        if sz[p_root] < sz[q_root]: 
            id[p_root] = q_root;
            sz[q_root] += sz[p_root] 
        else:
            id[q_root] = p_root
            sz[p_root] += sz[q_root] 
    elif op == "?":
        if p_root == q_root:
            results.append("yes")
        else:
            results.append("no")

print("\n".join(results))
