s = raw_input()
s = s[::-1]

result = []

back_counter = 0
for i in range(len(s)):
    c = s[i] 
    if c == '<':
       back_counter += 1 
    elif back_counter > 0:
        back_counter -= 1 
        # Ignore character
    else:
        result.append(c)


print (''.join(result)[::-1])
