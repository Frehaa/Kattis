readInt s = read s :: Int

read_int_pair = do
    line <- getLine 
    let (i1, i2) = break (==' ') line
    return (readInt i1, readInt i2) 

main = do
    (r1, s) <- read_int_pair
    let r2 = s * 2 - r1
    print r2
