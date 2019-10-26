import Data.List (foldl')
import Control.Monad

-- Returns the number of elements to remove from left, right end of list
-- As well as whether to reverse it in the end
parseProgram p = (if left then (a, b) else (b, a), not left)
  where ((a, b), left) = foldl' f ((0, 0), True) p
        f ((a, b), left) 'R' = ((b,a), not left)
        f ((a, b), left) 'D' = ((a+1, b), left)

reduceList xs (0, 0) True = Just (reverse xs)
reduceList xs (0, 0) False = Just xs
reduceList xs (0, r) True = reduceList (reverse xs) (r, 0) False
reduceList xs (0, r) False = reduceList (reverse xs) (r, 0) True
reduceList [] (x, y) _ = Nothing
reduceList (_:xs) (l, r) flip = reduceList xs (l-1, r) flip

solve :: (String, [Int]) -> String
solve (p, is) = 
  let ((l, r), flip) = parseProgram p in
  case reduceList is (l, r) flip of
    Nothing -> "error"
    Just l -> show l

readProgram :: IO (String, [Int])
readProgram = do 
  program <- getLine
  list <- getLine >> readLn :: IO [Int]
  return (program, list) 

main = do 
    n <- readLn :: IO Int
    programs <- replicateM n readProgram
    let results = map solve programs
    putStr $ unlines results 
