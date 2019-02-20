import sys

class Stack:
    class Node:
        def __init__(self):
            self.item = None
            self.next = None
            
    def __init__(self):
        self._first = None
        self._n = 0
        self.name = "stack"

    def is_empty(self):
        return self._n == 0

    def add(self, item):
        oldfirst = self._first
        self._first = Stack.Node()
        self._first.item = item
        self._first.next = oldfirst        
        self._n += 1
    
    def remove(self):
        if self.is_empty(): raise ValueError("Stack underflow")
        item = self._first.item
        self._first = self._first.next
        self._n -= 1
        return item

class Queue:
    class Node:
        def __init__(self, item, next):
            self.item = item
            self.next = next

    def __init__(self):
        self._first = None
        self._last = None
        self._n = 0
        self.name = "queue"

    def add(self, item):
        old_last = self._last
        self._last = self.Node(item, None)
        if self.is_empty():
            self._first = self._last
        else:
            old_last.next = self._last
        self._n += 1

    def remove(self):
        if self.is_empty():
            raise NoSuchElementException("Queue underflow")

        item = self._first.item
        self._first = self._first.next
        self._n -= 1
        if self.is_empty():
            self._last = None
        return item

    def is_empty(self):
        return self._first is None

class MaxPQ:
    def __init__(self, _max=1):
        self._pq = [None] * (_max + 1)
        self._n = 0
        self.name = "priority queue"

    def add(self, x):
        if self._n == len(self._pq) - 1:
            self._resize(2 * len(self._pq))
        self._n += 1
        self._pq[self._n] = x
        self._swim(self._n)

    def remove(self):
        if self.is_empty():
            raise NoSuchElementException("Priority queue underflow")

        _max = self._pq[1]
        self._exch(1, self._n)
        self._n -= 1
        self._sink(1)
        self._pq[self._n + 1] = None
        if self._n > 0 and self._n == (len(self._pq) - 1) // 4:
            self._resize(len(self._pq) // 2)
        return _max

    def is_empty(self):
        return self._n == 0
    
    def _sink(self, k):
        while 2*k <= self._n:
            j = 2*k
            if j < self._n and self._less(j, j+1):
                j += 1
            if not self._less(k, j):
                break
            self._exch(k, j)
            k = j

    def _swim(self, k):
        while k > 1 and self._less(k//2, k):
            self._exch(k, k//2)
            k = k//2

    def _resize(self, capacity):
        temp = [None] * capacity
        for i in range(1, self._n + 1):
            temp[i] = self._pq[i]
        self._pq = temp

    def _less(self, i, j):
        return self._pq[i] < self._pq[j]

    def _exch(self, i, j):
        self._pq[i], self._pq[j] = self._pq[j], self._pq[i]


lines = []

for line in sys.stdin:
    split = line.split()
    if len(split) == 1:
        lines.append(int(line))
    elif len(split) == 2:
        lines.append((int(split[0]), int(split[1])))


results = []

l = 0
while l < len(lines):
    n = lines[l]

    structures = [Stack(), Queue(), MaxPQ()]

    for i in range(n):
        c, v = lines[l + i + 1] 
        if c == 1:
            for structure in structures: structure.add(v)
        elif c == 2:
            # Remove and test on v
            for si in range(len(structures)-1, -1, -1):
                structure = structures[si]
                if structure.is_empty():
                    structures.remove(structure)
                else:
                    t = structure.remove()
                    if t != v:
                        structures.remove(structure)
        if len(structures) == 0:
            break

    if len(structures) == 0:
        results.append("impossible")
    elif len(structures) > 1:
        results.append("not sure")
    else:
        results.append(structures[0].name)

    l = l + n + 1

print ("\n".join(results))
