import Data.List

fizifier x y i = 
    case (i `mod` x == 0, i `mod` y == 0) of 
        (True, True) -> "FizzBuzz"
        (True, False) -> "Fizz"
        (False, True) -> "Buzz"
        (False, False) -> show i

main = do
    line <- getLine
    let x:y:n:rs = map (read :: [Char] -> Int) (words line)
    let result = [fizifier x y i | i <- [1..n]]
    putStr (unlines result)