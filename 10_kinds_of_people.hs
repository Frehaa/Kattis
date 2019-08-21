import Data.Char
import qualified Data.Map as M
import Data.Function
import Control.Monad

getWhile :: (Char -> Bool) ->  IO String
getWhile p = do
    c <- getChar
    if p c then 
        fmap ((:) c) (getWhile p)
    else return []

getInt :: IO Int
getInt = fmap read (getWhile isDigit)

type Coord = (Int, Int)
type Bound = (Int, Int)
type Size = Int
type Element = (Coord, Size)
type UF = M.Map Coord Element

nextCoord :: Coord -> Bound -> Coord
nextCoord (x, y) (bx, _) = if x < bx then (x + 1, y) else (0, y + 1)

defaultElement :: Coord -> UF -> (Element, UF)
defaultElement coord uf = 
    (ele, M.insert coord ele uf)
    where ele = (coord, 1)

isRoot :: UF -> Coord -> Element -> (Element, UF)
isRoot coord (parent, _) =
    coord == parent 

-- find' :: Coord -> UF -> (Element, UF)
-- find' coord uf = 
-- let ele = uf M.!? coord in 
-- maybe (defaultElement coord uf) (isRoot uf coord
--             (\ele -> if isRoot coord ele then (ele, uf) else find' parent uf) ele

-- union :: Coord -> Coord -> UF
-- union p q uf = 
--     case find p uf of 
--         Nothing -> 
--         Just (pRoot, pSize) -> 

--     (pRoot, pSize) <- find p uf
--     (qRoot, qSize) <- find q uf
--     if pSize > qSize then
--         insert qRoot (pRoot, qSize) uf &
--         insert pRoot (pRoot, pSize + qSize) 
--     else 
--         insert qRoot (pRoot, qSize) uf &
--         insert pRoot (pRoot, pSize + qSize)
    

handleChar :: Char -> Coord -> UF -> UF
handleChar c coord uf = uf

handleLine :: String -> Coord -> UF -> UF
handleLine line (x, y) uf = M.insert (x, y) ((x, y), 1) uf

main = do
    r <- getInt
    c <- getInt
    map <- replicateM r getLine

    foldr (\(coord, element) uf -> M.insert coord element uf) M.empty [((0,0), (0, 1))] & print

    
    
