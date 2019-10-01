import Control.Monad

doStuff :: IO ()
doStuff = do
    l1 <- getLine
    l2 <- getLine

    putStrLn l1
    putStrLn l2
    putStrLn $ zipWith (\x y -> if x == y then '.' else '*') l1 l2
    putStrLn ""

main = do 
    n <- fmap read getLine
    replicateM n doStuff
