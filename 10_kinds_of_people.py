import sys

lines = sys.stdin.readlines()
r, c = map(int, lines[0].split())

def c2i(x, y): 
    return (y * c + x)

size = [1 for _ in range(r) for _ in range(c)]
parent = [c2i(x,y) for y in range(r) for x in range(c)]

def find(q):
    while (parent[q] != q): 
        q = parent[q]
    return q

def union(p, q):
    p_root = find(p)
    q_root = find(q)

    if (size[p_root] < size[q_root]):
        parent[p_root] = q_root
        size[q_root] += size[p_root]
    else:
        parent[q_root] = p_root
        size[p_root] += size[q_root]

def neighbours(x, y):
    result = []
    if (x != 0):
        result.append((x - 1, y))
    if (y != 0):
        result.append((x, y - 1))
    return result

world = map(lambda x: x.strip(), lines[1:1+r])

for y in range(r):
    for x in range(c):
        faction = world[y][x]
        for (nx, ny) in neighbours(x, y):
            if world[ny][nx] == faction: 
                union(c2i(x, y), c2i(nx, ny))

for l in lines[r + 2:]:
    y1, x1, y2, x2 = map(lambda x: x - 1, map(int, l.split()))
    if (find(c2i(x1, y1)) == find(c2i(x2, y2))): 
        if (world[y1][x1] == '1'): print "decimal"
        else: print "binary"
    else:
        print "neither"
