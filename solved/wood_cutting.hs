import Data.List (sort)

readInput :: String -> [Int]
readInput = map read . tail . words

readNCustomers :: Int -> [Int] -> ([Int], [Int])
readNCustomers = loop [] 
    where loop acc 0 is = (acc, is)
          loop acc n (i:is) = loop (sum ws:acc) (n-1) is'
            where (ws, is') = splitAt i is

splitTests :: [Int] -> [[Int]]
splitTests = split' []
    where split' acc [] = reverse acc
          split' acc (n:is) = split' acc' is'
            where acc' = cs:acc
                  (cs, is') = readNCustomers n is

solve :: [Int] -> String
solve cs = loop 0 cs' i
    where loop t [] 0 = show (fromIntegral t / fromIntegral i)
          loop t [] _ = "what size?"
          loop t _ 0 = "what cs?"
          loop t (c:cs) i = loop (t + c * i) cs (i-1)
          cs' = sort cs
          i = length cs'

main = interact(unlines . (map solve) . splitTests . readInput)
