
f r e c
  | r > a = "do not advertise"
  | r < a = "advertise"
  | otherwise = "does not matter"
  where a = e-c

solve [] = []
solve (r:e:c:xs) = f r e c : solve xs

main = interact (unlines . solve . tail . fmap read . words)
