top_right <- 1
top_left <- 2
bottom_left <- 3
bottom_right <- 4

decide_quadrant :: Int -> Int -> Int
decide_quadrant x y 
    | x > 0 && y > 0 = top_right
    | x < 0 && y > 0 = top_left
    | x > 0 && y < 0 = bottom_right
    | x < 0 && y < 0 = bottom_left
    | otherwise  = error "No quadrant"

main = do 
    x <- readLn :: IO Int
    y <- readLn :: IO Int
    print (decide_quadrant x y)
