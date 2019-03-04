digit_n x n = (x `mod` 10^n) `div` 10^(n-1)

log10 = logBase $ fromIntegral 10
num_length num = ceiling $ log10 $ fromIntegral num 

main = do
    a <- readLn :: IO Int
    b <- readLn :: IO Int 
    let len_a = num_length a
    let len_b = num_length b
    let length = max len_a len_b
    print length 
