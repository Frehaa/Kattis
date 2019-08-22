import sys
from collections import defaultdict 

lines = sys.stdin.readlines()

def toPair(s):
    a,b = map(int, s.split())
    return (a, b)

pairs = map(toPair, map(lambda s: s.strip(), lines[1:]))
varMap = defaultdict(list) # Map from results to pairs
valMap = defaultdict(int) # Map from results to counts

assignment = defaultdict(None)

def add(a, b): return a + b
def sub(a, b): return a - b
def mult(a, b): return a * b

def domain((a, b)):
    for op in [add, sub, mult]:
        yield op(a, b)

def addVariable(pair):
    for v in domain(p):
        varMap[v].append(p)
        valMap[v] = valMap[v] + 1

def removeVariable(pair):
    for v in domain(pair): 
        varMap[v].remove(pair)
        if varMap[v] == []: del varMap[v]
        valMap[v] = valMap[v] - 1
        if valMap[v] == 0: del valMap[v]

def pickVariable(): # Least restrictive 
    bk, bv = None, 0
    for k in valMap:
        if valMap[k] == 0 or assignment.get(k, None) != None: continue
        if valMap[k] == 1: return k
        if valMap[k] > bv:
            bk, bv = (k, valMap[k])
    return bk

def assign(var, v):
    assignment[v] = var
    removeVariable(var)

def revert(var, v):
    assignment[v] = None
    addVariable(var)

def removeSingles(): 
    for v in valMap.keys():
        if valMap[v] == 1: 
            if len(varMap[v]) != 1: continue
            var = varMap[v][0]
            assign(var, v)

def backtrack():
    if sum(valMap.values()) == 0: return True
    var = pickVariable()
    if var is None: return False
    var = varMap[var][0]

    for v in domain(var):
        if assignment.get(v, None) == None:
            assign(var, v)
            if backtrack(): return True
            revert(var, v)
    return False

def getOp((a, b), v):
    if a + b == v: return "+"
    elif a - b == v: return "-"
    else: return "*"
    

def printAssignment():
    test = defaultdict(list)

    for k in assignment:
        test[assignment[k]].append(k)
    
    for p in pairs: 
        v = test[p].pop()
        op = getOp(p, v)
        a, b = p
        print "%i %s %i = %i" % (a, op, b, v)
        
for p in pairs:
    addVariable(p)

removeSingles()
if backtrack(): 
    printAssignment()
else:
    print "impossible"
