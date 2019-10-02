import Data.List (sortBy)

cmp a b 
    | snd a < snd b = LT
    | snd a > snd b = GT
    | otherwise     = EQ

makePairs acc [] = acc
makePairs acc (s:f:is) = makePairs ((s,f):acc) is

solve i _ [] = i
solve i f ((s', f'):ps)
    | f <= s'   = solve (i+1) f' ps
    | otherwise = solve i f ps

main = interact(show . solve 0 0 . sortBy cmp . makePairs [] . (map read) . tail . words)
