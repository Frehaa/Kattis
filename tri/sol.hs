
main = do
  a:b:c:[] <- fmap (map read . words) getLine :: IO [Int]
  
  if a == b * c then
    putStrLn (show a ++ "=" ++ show b ++ "*" ++ show c)
  else if a * b == c then
    putStrLn (show a ++ "*" ++ show b ++ "=" ++ show c)
  else if a == b + c then 
    putStrLn (show a ++ "=" ++ show b ++ "+" ++ show c)
  else if a + b == c then 
    putStrLn (show a ++ "+" ++ show b ++ "=" ++ show c)
  else if a == b - c then 
    putStrLn (show a ++ "=" ++ show b ++ "-" ++ show c)
  else if a - b == c then 
    putStrLn (show a ++ "-" ++ show b ++ "=" ++ show c)
  else if a == b `div` c then 
    putStrLn (show a ++ "=" ++ show b ++ "/" ++ show c)
  else --if a / b == c then 
    putStrLn (show a ++ "/" ++ show b ++ "=" ++ show c)

