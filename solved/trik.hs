import Data.List (foldl')

a 1 = 2
a 2 = 1
a 3 = 3

b 1 = 1
b 2 = 3
b 3 = 2

c 1 = 3
c 2 = 2
c 3 = 1

f 'A' = a
f 'B' = b
f 'C' = c
f _ = id

solve s = show . foldl' (flip (.)) id (map f s) $ 1

main = interact solve
