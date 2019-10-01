import qualified Data.Vector as V

type Memoizer = V.Vector (V.Vector Int)

(!) :: Memoizer -> (Int, Int) -> Int
m ! (i, c) = (m V.! i) V.! c

fromList = V.fromList

newtype Result = Result { result :: [Int] } 
instance Show Result where
    show (Result vs) = show (length vs) ++ "\n" ++ (unwords . map show $ vs)

type Capacity = Int
type Value = Int
type Index = Int
type Weight = Int

data Item = Item Index Value Weight deriving Show
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
knapsack (c, items) = Result (findSolution mem items c [])
    where mem = fromList [fromList (map (opt i) [0..c]) | i <- reverse items]
          opt _ 0 = 0
          opt (Item 0 v w) c
                | w <= c    = v
                | otherwise = 0
          opt (Item i v w) c 
                | w <= c    = max (v + mem ! (i-1, c-w)) (mem ! (i-1, c))
                | otherwise = mem ! (i-1, c)

findSolution :: Memoizer -> [Item] -> Capacity -> [Int] -> [Int]
findSolution _ _  0 acc = acc
findSolution _ [] _ acc = acc
findSolution mem (i:items) c acc
    | weight i > c  = findSolution mem items c acc
    | j == 0 = [j]
    | v + mem ! (j - 1, c - w) >= mem ! (j-1, c) =
        findSolution mem items (c - w) (j:acc)
    | otherwise = findSolution mem items c acc
    where j = index i 
          v = value i 
          w = weight i

main = interact(writeOutput . (map knapsack) . splitTests . readInput)
