solve :: [Int] -> [Int]
solve (n:m:_) = 
  let diff = abs (n-m)
      start = 1 + min n m in
  [start..start+diff]


main = interact (unlines . fmap show . solve . fmap read . words)
