import Data.Map (Map, fromList, (!))

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
splitTests (c:n:is) = (c, vs): splitTests is'
    where (vs, is') = readTestValues n is
splitTests _ = []

readTestValues :: Int -> [Int] -> ([Item], [Int])
readTestValues n is = 
    let (vs, is') = splitAt (2*n) is in 
    (toItems 0 vs, is')
    where toItems i (v:w:vs) = (Item i v w) : toItems (i + 1) vs
          toItems _ _ = []

writeOutput :: [Result] -> String
writeOutput = unlines . map show

-- Solution

knapsack :: (Capacity, [Item]) -> Result
knapsack (c, items) = Result (findSolution mem (reverse items) c) 
    where mem = fromList asocList 
          asocList = do 
            c' <- [0..c]
            i <- items 
            return ((index i, c'), opt i c')
          opt _ 0 = 0
          opt (Item 0 v w) c
                | w <= c    = v
                | otherwise = 0
          opt (Item i v w) c 
                | w <= c    = max (v + mem ! (i-1, c-w)) (mem ! (i-1, c))
                | otherwise = mem ! (i-1, c)

findSolution :: Map (Index, Capacity) Value -> [Item] -> Capacity -> [Int]
findSolution _ _  0 = []
findSolution _ [] _ = []
findSolution mem (i:items) c 
    | weight i > c  = findSolution mem items c
    | j == 0 = [j]
    | v + mem ! (j - 1, c - w) >= mem ! (j-1, c) =
        j : findSolution mem items (c - w)
    | otherwise = findSolution mem items c
    where j = index i 
          v = value i 
          w = weight i

main = interact(writeOutput . (map knapsack) . splitTests . readInput)
