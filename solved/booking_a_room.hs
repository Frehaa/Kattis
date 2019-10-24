solve :: [Int] -> [Int]
solve (n:_:is) = foldr (\i s -> filter ((/=)i) s) [1..n] is

toResult [] = "too late"
toResult xs = show . head $ xs

main = interact (toResult . solve . fmap read . words)
