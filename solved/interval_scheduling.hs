import Prelude hiding (min)

-- Min Ordered Priority Queue
data PQ v = Nil | Node Int (PQ v) v (PQ v) deriving (Show)

size :: PQ v -> Int
size Nil = 0
size (Node s _ _ _) = s

insertBy ::  (v -> v -> Bool) -> PQ v -> v -> PQ v
insertBy _ Nil a = Node 1 Nil a Nil
insertBy cmp (Node s l v r) a
     | a `cmp` v = 
        if sl <= sr 
        then Node (s + 1) (insert l v) a r 
        else Node (s + 1) l a (insert r v)
    | sl <= sr  = Node (s + 1) (insert l a) v r
    | otherwise = Node (s + 1) l v (insert r a)
    where insert pq = insertBy cmp pq
          sl = size l
          sr = size r

min :: PQ v -> v
min (Node _ _ v _) = v

removeMinBy :: PQ v -> (v -> v -> Bool) -> PQ v
removeMinBy Nil _ = Nil
removeMinBy (Node s l v Nil) _ = l
removeMinBy (Node s Nil v r) _ = r
removeMinBy (Node s l v r) cmp
    | min l `cmp` min r = 
        Node (s - 1) (removeMinBy l cmp) (min l) r
    | otherwise     = 
        Node (s - 1) l (min r) (removeMinBy r cmp)

-- Solution 
cmp a b = snd a < snd b

buildPq :: PQ (Int, Int) -> [Int] -> PQ (Int, Int)
buildPq pq [] = pq
buildPq pq (s:f:is) = buildPq pq' is
    where pq' = insertBy cmp pq (s, f)

solve :: Int -> Int -> PQ (Int, Int) -> Int
solve _ i Nil = i
solve f i pq
    | f <= s'   = solve f' (i + 1) pq'
    | otherwise = solve f i pq'
    where (s', f') = min pq
          pq' = removeMinBy pq cmp

main = interact(show . solve 0 0 . buildPq Nil . map read . tail .words)
