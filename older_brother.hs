import Data.List

sieve :: [Int] -> [Int]
sieve [] = []
sieve (p:ps) = 
    p : sieve (filter (\x -> x `mod` p /= 0) ps)

highest_prime = floor.sqrt.fromIntegral

binary p q lo hi
    | lo > hi   = Nothing
    | t == q    = Just mid
    | t < q     = binary p q (mid + 1) hi
    | t > q     = binary p q lo (mid - 1)
    where mid = lo + (hi-lo) `div` 2 
          t = p ^ mid

main = do 
    q <- readLn :: IO Int
    let ma = highest_prime q
    let nums = [2..ma] ++ (if q > ma then [q] else [])
    let primes = sieve nums
    if any (\p -> binary p q 1 30 /= Nothing) primes 
        then putStrLn "yes" 
        else putStrLn "no" 