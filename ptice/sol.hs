import Data.List (sortOn)

adrianAns = "ABC"++adrianAns
brunoAns = "BABC"++brunoAns
goranAns = "CCAABB"++goranAns

indicator a b 
  | a == b = 1
  | otherwise = 0

main = do
  getLine
  answers <- getLine
  let adrianRes = (sum $ zipWith indicator answers adrianAns, "Adrian")
  let brunoRes = (sum $ zipWith indicator answers brunoAns, "Bruno")
  let goranRes = (sum $ zipWith indicator answers goranAns, "Goran")

  let a:b:c:[] = sortOn fst [adrianRes, brunoRes, goranRes]
  
  print (fst c)

  if (fst c) == (fst b) then do
    if (fst c) == (fst a) then
      putStrLn (snd a)
    else return ()
    putStrLn (snd b)
  else return ()
  putStrLn (snd c)
