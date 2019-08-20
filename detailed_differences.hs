
getInt :: IO Int
getInt = fmap read getLine

main = do 
    n <- getInt
    print n
    l1 <- getLine
    l2 <- getLine



    print (l1 ++ l2)
