import sys
import random as rand

def create_program(length):
    result = []
    for _ in range(length):
        if rand.randint(0, 1) == 1:
            result.append("R")
        else:
            result.append("D")

    return ''.join(result)

def create_list(lenght):
    result = []
    for _ in range(lenght):
        num = rand.randint(1, 100)
        result.append(str(num))

    return "[" + ','.join(result) + "]"

test_cases = rand.randint(1, 100)

print test_cases

for _ in range(test_cases):
    program_length = rand.randint(1, 100)
    list_length = rand.randint(0, 100)
    print create_program(program_length)
    print list_length
    print create_list(list_length)