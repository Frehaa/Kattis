import Control.Monad

readProgram :: IO (String, [Int])
readProgram = do
    program <- getLine
    list <- getLine >> getLine
    return (program, read list)

applyCommand :: [Char] -> ()

applyProgram :: String -> [Int] -> [Int]
applyProgram program intList = [5]

handleProgram :: IO [Int]
handleProgram = do 
    (program, intList) <- readProgram
    return (applyProgram program intList)

main = do 
    list <- replicateM 5 handleProgram
    print list
    