solve :: [String] -> Double
solve [] = 0.0
solve (q:y:ws) = q' * y' + solve ws
    where q' = read q 
          y' = read y

main = interact (show . solve . drop 1 . words)
