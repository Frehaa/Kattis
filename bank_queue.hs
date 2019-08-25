import Data.Char (isDigit)
import Data.List (foldl', sortBy)
import Control.Monad (replicateM)
import Prelude hiding (min, foldl)

-- import Debug.Trace (traceShow, trace)

-- Some convenient IO stuff
getWhile :: (Char -> Bool) ->  IO String
getWhile p = do
    c <- getChar
    if p c then 
        fmap ((:) c) (getWhile p)
    else return []

getInt :: IO Int
getInt = fmap read (getWhile (\c -> isDigit c || c == '-'))

getIntPair :: IO (Int, Int)
getIntPair = do 
    a <- getInt 
    b <- getInt 
    return (a, b)

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

min :: PQ v -> Maybe v
min Nil = Nothing
min (Node _ _ v _) = Just v

removeMinBy :: PQ v -> (v -> v -> Bool) -> PQ v
removeMinBy Nil _ = Nil
removeMinBy (Node s l v Nil) _ = l
removeMinBy (Node s Nil v r) _ = r
removeMinBy (Node s l v r) cmp
    | min l `cmp'` min r = 
        let Just v' = min l in
        Node (s - 1) (removeMinBy l cmp) v' r
    | otherwise     = 
        let Just v' = min r in
        Node (s - 1) l v' (removeMinBy r cmp)
    where cmp' (Just a) (Just b) = cmp a b

foldl :: (a -> v -> a) -> a -> PQ v -> a
foldl _ s Nil = s
foldl f s (Node _ l v r) = 
    let s'' = f s' v in foldl f s'' r
    where s' = foldl f s l 
            
-- Problem logic
reduce :: [(Int, Int)] -> [(Int, Int)]
reduce = reverse . fst . foldl' f ([], (0, 0)) . sortBy cmp
    where f (acc, (c, i')) x@(_, i)
            | i < i'    = (acc, (0, i'))
            | i > i'    = (x:acc, (1, i)) 
            | i >= c    = (x:acc, (c + 1, i'))
            | otherwise = (acc, (0, i' + 1))
          cmp (a1, b1) (a2, b2) 
            | b1 == b2  = compare a2 a1 
            | otherwise = compare b1 b2

-- Replace smallest element in PQ while p holds and the elements in the list are
-- larger (Assumes sorted list for early stopping)
replaceNWhile :: Int -> (Int -> Bool) -> [(Int, Int)] -> PQ Int -> (PQ Int, [(Int, Int)])
replaceNWhile n _ [] pq = (pq, [])
replaceNWhile 0 _ xs pq = (pq, xs)
replaceNWhile n p xs@((v, w):xs') pq
    | p w && m < v = replaceNWhile (n - 1) p xs' pq'
    | otherwise    = (pq, xs)
    where Just m = min pq
          pq' = insert (removeMin pq) v
          insert = insertBy (<)
          removeMin pq = removeMinBy pq (<)

sumBest :: [(Int, Int)] -> Int
sumBest xs = 
    loop xs 1 0 Nil
    where loop [] _ _ pq = foldl (+) 0 pq
          loop ps@((v, w):ps') i n pq
            | w < n     = loop ps' i n pq                        -- Ignore people with this wait time
            | w > n     = loop ps (i + (w - n)) w pq             -- We skipped some wait times so this is to catch up
            | i > 0     = loop ps' (i - 1) n (insertBy (<) pq v) -- We need to insert people from this wait time no questions asked
            | otherwise =                                        -- We need to check the remaining customers if they can replace any of our previous best
                let (pq', ps'') = replaceNWhile n (==w) ps pq in 
                loop ps'' (i + 1) (n + 1) pq'
            
main = do
    n <- getInt
    t <- getInt
    pairs <- replicateM n getIntPair

    print (sumBest . reduce $ pairs)
