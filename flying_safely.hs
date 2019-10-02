import Data.List (splitAt, sort)
import Data.List.Extra (groupSort)
import Data.Map (Map, (!), fromList, size, foldr)
import qualified Data.Set as S

import Prelude hiding (foldr)

data Node = Node Int [Node] 
type Graph = Map Int Node

readInput :: String -> [Int]
readInput = map read . tail . words

toPairs :: [Int] -> [(Int, Int)]
toPairs = tp []
    where tp acc [] = acc
          tp acc (x1:x2:xs) = tp ((x1, x2):(x2, x1):acc) xs

splitTests :: [Int] -> [(Int, [(Int, Int)])]
splitTests = split' []
    where split' acc [] = reverse acc 
          split' acc (n:m:is) = split' acc' is'
            where (ps, is') = splitAt (2*m) is
                  acc' = (n, toPairs ps):acc

buildGraph :: (Int, [(Int, Int)]) -> Graph
buildGraph (n, as) = g
    where g = fromList asocList
          asocList = do 
            (i, ns) <- groupSort as
            return (i, Node i (map (g!) ns))

solve :: Graph -> String
solve g = foldr k 0 g 
    where k n s = max s $ bfs g n
    
data Queue a = ([a], [a])
queue = ([], [])

singleton a = ([], [a])

isEmpty ([], []) = True
isEmpty _ = False

enqueue (fs, bs) a = (a:fs, bs)

dequeue (fs, []) = dequeue ([], reverse fs)
dequeue (fs, x:bs) = (x, (fs, bs))

bfs :: Graph -> Node -> Int
bfs g (Node i ns) = bfs' (singleton i) S.empty 0
    where bfs' q s i = 
        where (Node _ ns) = g ! x
              s' = S.insert x s
              (x, q') = dequeue q
              q'' =  foldl enqueue q' ns
              
              

main = interact(unlines . map (solve.buildGraph) . splitTests . readInput)
-- main = interact(show . length . splitTests . readInput)
