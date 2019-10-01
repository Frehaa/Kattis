import sys
import ipdb

def readline():
    return sys.stdin.readline()

n = int(readline())

minions = []
for _ in range(n):
    lo, hi = readline().split()
    minions.append((int(lo), int(hi)))

minions.sort()

i = 0
room_count = 0
while i < len(minions):
    room_count += 1
    lowest_max = 2 * n
   
    for l in range(i, len(minions)):
        _, hi = minions[i]
        if hi < lowest_max: lowest_max = hi


    # Allocate all minions with lower minimum than the lowest max to this room
    while i < len(minions):
        lo, _ = minions[i] 
        if lo > lowest_max: break
        i += 1

print (room_count) 
