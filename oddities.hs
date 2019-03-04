
read_n_print 1 = do
    x <- readLn :: IO Int
    if (x `mod` 2 == 0) then 
        putStrLn (show x ++ " is even")
    else 
        putStrLn (show x ++ " is odd")

read_n_print n = do 
    read_n_print 1 
    read_n_print (n - 1)

main = do
    n <- readLn :: IO Int
    read_n_print n
