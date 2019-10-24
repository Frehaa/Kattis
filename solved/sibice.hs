maxLength :: (RealFrac a, Floating a, Integral b) => a -> a -> b
maxLength a b = floor . sqrt $ a ** 2 + b ** 2

solve :: [Int] -> String
solve (_:w:h:xs) = unlines $ map f xs
  where m = maxLength (fromIntegral w) (fromIntegral h)
        f x 
          | x <= m    = "DA"
          | otherwise = "NE"


main = interact (solve . map read . words)
