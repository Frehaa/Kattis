import Data.List

read_n_ints 1 = do 
    i <- readLn :: IO Int
    return [i]

read_n_ints n = do
    i <- readLn :: IO Int
    is <- read_n_ints (n-1)
    return ([i] ++ is)

main = do 
    x <- readLn :: IO Int
    n <- readLn :: IO Int
    is <- read_n_ints n
    let result = foldl' (\s i -> (x - i) + s) x is
    print result
