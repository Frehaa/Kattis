import sys

lines = sys.stdin.readlines()

N, _ = lines[0].split()
N = int(N)

parent = [i for i in range(N+1)]
ref = [i for i in range(N+1)]
sizes = [1] * (N+1)
ele_sum = [i for i in range(N+1)]

def find(p):
    p = ref[p]
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
        ele_sum[pp] += ele_sum[qp]
        parent[qp] = pp
    else:
        sizes[qp] += sizes[pp]
        ele_sum[qp] += ele_sum[pp]
        parent[pp] = qp

def move(p, q):
    pp_old = find(p)
    sizes[pp_old] -= 1
    ele_sum[pp_old] -= p

    qp = find(q)
    sizes[qp] += 1
    ele_sum[qp] += p

    ref[p] = ref[q]
    

res = []
for i in range(1, len(lines)):
    vals = lines[i].split()
    op = vals[0]

    if op == "1":
        union(int(vals[1]),int(vals[2]))
    elif op == "2":
        move(int(vals[1]),int(vals[2]))
    elif op == "3":
        p = find(int(vals[1]))
        res.append(f"{sizes[p]} {ele_sum[p]}")
    elif op == "?":
        res.append("yes" if connected(int(vals[1]), int(vals[2])) else "no")
    elif op == "=":
        union(int(vals[1]),int(vals[2]))

print("\n".join(res))
