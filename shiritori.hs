import Data.Set
import Data.Typeable

read_n_lines 1 = do
    line <- getLine
    print (line ++ " " ++ line)
    return [line]

read_n_lines n = do
    l <- read_n_lines 1 
    ls <- read_n_lines (n-1)
    return (l ++ ls) 

other_player 1 = 2
other_player 2 = 1
other_player x = 0

game :: [String] -> Set String -> Int -> Int
game [] s p = 0

game (l:[]) s p = 
    if member l s then other_player p
    else 0

game (l1:l2:ls) s p = 
    if last l1 /= head l2 then p
    else if member l2 s then p
    else game (l2:ls) (insert l1 s) (other_player p)

main = do
    n <- readLn :: IO Int
    lines <- read_n_lines n
    let game_result = game lines empty 2
    if game_result == 1 then putStrLn "Player 1 lost"
    else if game_result == 2 then putStrLn "Player 2 lost"
    else putStrLn "Fair Game"