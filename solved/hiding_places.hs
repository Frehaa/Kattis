import Data.Char (isDigit)
import Data.List (foldl', sortBy, sort)
import Control.Monad (replicateM)
import qualified Data.Set as S
import Prelude hiding (min, foldl)
getWhile :: (Char -> Bool) ->  IO String
getWhile p = do
    c <- getChar
    if p c then 
        fmap ((:) c) (getWhile p)
    else return []

getInt :: IO Int
getInt = fmap read (getWhile isDigit)

i2c :: Int -> Char
i2c i = case i of
    0 -> 'a'
    1 -> 'b'
    2 -> 'c'
    3 -> 'd'
    4 -> 'e'
    5 -> 'f'
    6 -> 'g'
    7 -> 'h'

c2i :: Char -> Int
c2i c = case c of
    '1' -> 0
    'a' -> 0
    '2' -> 1
    'b' -> 1
    '3' -> 2
    'c' -> 2
    '4' -> 3
    'd' -> 3
    '5' -> 4
    'e' -> 4
    '6' -> 5
    'f' -> 5
    '7' -> 6
    'g' -> 6
    '8' -> 7
    'h' -> 7

getChessPosition :: IO (Int, Int)
getChessPosition = do
    x:y:_ <- getLine
    return (c2i x, c2i y)


move :: (Int, Int) -> [(Int, Int)]
move x = filter p . map (add x) $ moves
    where moves = [(2, 1), (2,-1), (1, 2), (1,-2), (-1, 2), (-1,-2), (-2, 1), (-2,-1)] 
          p (x, y) = 0 <= x && x <= 7 && 0 <= y && y <= 7
          add (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)

find_hiding_places :: (Int, Int) -> (Int, [(Int, Int)])
find_hiding_places x = bfs 0 (S.singleton x) (S.singleton x)
    where bfs i ms s
            | S.size s == 64 = (i, S.toList ms)
            | otherwise      = 
                let ms' = S.filter (not . (flip S.member) s) . S.foldr (\x s -> foldr S.insert s (move x)) s $ ms
                    s'  = s `S.union` ms' in 
                bfs (i + 1) ms' s'

toCNotation :: (Int, Int) -> String
toCNotation (x, y) = i2c x : show (y + 1)

pprint :: [(Int, [(Int, Int)])] -> IO ()
pprint [] = return ()
pprint ((i, hss):xs) = 
    let hss' = sortBy cmp hss in do
    putStrLn (show i ++ (foldl' (\x s -> x ++ " " ++ s) "" . map toCNotation $ hss'))
    pprint xs
    where cmp (x1, y1) (x2, y2) 
            | y1 < y2 = GT
            | y1 > y2 = LT
            | otherwise = compare x1 x2

            
main = do
    n <- getInt
    ps <- replicateM n getChessPosition
    pprint . fmap find_hiding_places $ ps
