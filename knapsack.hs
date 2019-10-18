


import Debug.Trace (traceShow)


data Memoizer = Memoizer


newtype Result = Result { result :: [Int] } 
instance Show Result where
    show (Result vs) = show (length vs) ++ "\n" ++ (unwords . map show $ vs)

type Capacity = Int
type Value = Int
type Index = Int
type Weight = Int

data Item = Item Index Value Weight
index  (Item i _ _) = i
value  (Item _ v _) = v
weight (Item _ _ w) = w

-- IO 
readInput :: String -> [Int]
readInput = (map read) . words

splitTests :: [Int] -> [(Capacity, [Item])]
splitTests = reverse . split' [] -- Reverse to get tests in correct order since we use accumulator pattern
    where split' acc [] = acc
          split' acc (c:n:is) = split' ((c, vs):acc) is'
            where (vs, is') = readTestValues n is

readTestValues :: Int -> [Int] -> ([Item], [Int])
readTestValues n is = (toItems [] 0 $ vs, is') -- Don't reverse since this order is prefered
    where (vs, is') = splitAt (2*n) is
          toItems acc i (v:w:vs') = toItems (Item i v w:acc) (i + 1) vs'
          toItems acc _ _ = acc

writeOutput :: [Result] -> String
writeOutput = unlines . map show

-- Solution
knapsack :: (Capacity, [Item]) -> Result
knapsack (c, items) = undefined

findSolution :: Memoizer -> [Item] -> Capacity -> [Int] -> [Int]
findSolution mem items c acc = undefined

main = interact(writeOutput . (map knapsack) . splitTests . readInput)
