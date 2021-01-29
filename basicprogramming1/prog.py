_, t = input().split()
t = int(t)

A = input().split()
for i in range(len(A)):
    A[i] = int(A[i])

if t == 1:
    print(7)
elif t == 2:
    if A[0] > A[1]:
        print("Bigger")
    elif A[0] == A[1]:
        print("Equal")
    else:
        print("Smaller")
elif t == 3:
    print(sorted(A[0:3])[1])
elif t == 4:
    print(sum(A))
elif t == 5:
    print(sum(filter(lambda x: x % 2 == 0, A)))
elif t == 6:
    print("".join(map(lambda x: chr(x + 97),map(lambda x: x % 26, A))))
elif t == 7:
    i = 0
    while True:
        if i < 0 or i >= len(A):
            print("Out")
            break
        elif i == len(A)-1:
            print("Done")
            break
        elif i == A[i]:
            print("Cyclic")
            break
        tmp = A[i]
        A[i] = i
        i = tmp
