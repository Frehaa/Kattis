side_length 0 = 2
side_length n = 
    let s = side_length (n-1) in
    s + s - 1

calc_points n = 
    let l = side_length n in
    l * l

main = do
    n <- readLn :: IO Int
    print (calc_points n)