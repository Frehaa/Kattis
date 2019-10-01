
main = do
    i <- readLn :: IO Int
    if even i then putStrLn "Bob"
    else putStrLn "Alice"
