import Data.List (sortBy)

main :: IO ()
main = do
    getLine
    n <- fmap (fmap read) . fmap words $ getLine
    print $ foldr max 0 . zipWith (+) [2..] $ sortBy (flip compare) n
