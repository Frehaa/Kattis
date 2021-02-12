import sys

lines = sys.stdin.readlines()

N, _ = lines[0].split()
N = int(N)

parent = [i for i in range(N)]
sizes = [1] * N

def find(p):
    while p != parent[p]:
        parent[p] = parent[parent[p]]
        p = parent[p]
    return p

def connected(p, q):
    return find(p) == find(q)

def union(p, q):
    pp = find(p)
    qp = find(q)

    if pp == qp: return

    if sizes[pp] > sizes[qp]:
        sizes[pp] += sizes[qp]
        parent[qp] = pp
    else:
        sizes[qp] += sizes[pp]
        parent[pp] = qp

res = []
for i in range(1, len(lines)):
    op, a, b = lines[i].split()
    a = int(a)
    b = int(b)

    if op == "?":
        res.append("yes" if connected(a, b) else "no")
    elif op == "=":
        union(a,b)

print("\n".join(res))
