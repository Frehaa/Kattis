main = do
    line <- getLine
    let pairs = zip [1..] line
    let idxs = [i | (i, c) <- pairs, c == '-'] 
    putStrLn ([line !! i | i <- 0:idxs])