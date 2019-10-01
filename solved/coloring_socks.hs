import Control.Monad
import Data.Char
import Data.List

getWhile :: (Char -> Bool) ->  IO String
getWhile p = do
    c <- getChar
    if p c then 
        fmap ((:) c) (getWhile p)
    else return []

getInt :: IO Int
getInt = fmap read (getWhile isDigit)

type Capacity = Int
type ColorDifference = Int
type Sock = Int

laundrySocks :: Capacity -> ColorDifference -> [Sock] -> Int -> Int
laundrySocks c k [] acc = acc
laundrySocks c k ss acc = 
    let (acc', ss') = fillMachine 0 ss in laundrySocks c k ss' acc'
    where fillMachine i [] = (acc + 1, [])
          fillMachine i (x:xs) = if x <= (s + k) && i < c then fillMachine (i + 1) xs else (acc + 1, x:xs) 
          s:_ = ss

main = do
    args <- fmap words getLine 
    ints <- fmap words getLine 

    let _:c:k:[] = fmap read args :: [Int]
        ss = fmap read ints in 
            print (laundrySocks c k (sort ss) 0)
        
