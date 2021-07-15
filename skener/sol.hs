import Control.Monad

handleLine zr zc = do
  line <- getLine
  return $ replicate zr $ line >>= replicate zc

main = do
  r:_:zr:zc:[] <- fmap (map read . words) getLine :: IO [Int]
  lines <- replicateM r (handleLine zr zc)
  putStrLn (unlines $ join lines)

