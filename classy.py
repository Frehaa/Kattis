import sys

class_value = { 'upper': 1, 'middle': 2, 'lower':3 }

t = int(sys.stdin.readline())

result = []

for _ in range(t):
    n = int(sys.stdin.readline())

    people = []
    max_class_rank_length = 0
    for _ in range(n):
        line = sys.stdin.readline()
        name, rank, _ = line.split()
        name = name[:-1]

        class_rank = [class_value[r] for r in rank.split('-')]
        class_rank = class_rank[::-1]

        if len(class_rank) > max_class_rank_length:
            max_class_rank_length = len(class_rank)

        people.append((class_rank, name))

    for class_rank, _ in people:
        while len(class_rank) < max_class_rank_length:
            class_rank.append(2)

    people.sort(reverse=False)

    for _, name in people:
        result.append(name)
    result.append("="*30)

print("\n".join(result))
