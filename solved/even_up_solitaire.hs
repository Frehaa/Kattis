import Data.List

data EvenOdd = Even | Odd deriving (Show, Eq)

combine [] = []
combine xs = 
    let (t, _) = xs !! 0 in 
    let (a, b) = span ((==t).fst) xs in 
    (t, length a) : combine b

cards_left :: [(EvenOdd, Int)] -> Int
cards_left xs = 
    let xs' = combine xs in
    if length xs' == length xs 
        then length xs
        else cards_left (filter (odd.snd) xs')

main = do
    _ <- getLine
    line <- getLine
    let nums = map (read :: [Char] -> Int) (words line)
    let eo = map (\x -> if even x then Even else Odd) nums
    let eo' = zip eo [1..]
    print (cards_left eo')