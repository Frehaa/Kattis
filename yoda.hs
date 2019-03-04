digit_n x n = (x `mod` 10^n) `div` 10^(n-1)

main = do
    a <- readLn :: IO Int
    b <- readLn :: IO Int 
    print ("test")
