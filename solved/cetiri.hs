import Data.List

main = do
    line <- getLine
    let nums = map (read :: String -> Int) (words line)
    let a:b:c:[] = sort nums
    let diff1 = b - a
    let diff2 = c - b
    if diff1 == diff2 then 
        print (c + diff1)
    else if diff1 > diff2 then
        print (a + diff2)
    else
        print (b + diff1)