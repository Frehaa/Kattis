import Data.Char
import Data.List
import Control.Monad
import qualified Data.Set as S
import qualified Data.Map as M

import Debug.Trace

-- Some conventient IO stuff
getWhile :: (Char -> Bool) ->  IO String
getWhile p = do
    c <- getChar
    if p c then 
        fmap ((:) c) (getWhile p)
    else return []

getInt :: IO Int
getInt = fmap read (getWhile (\c -> isDigit c || c == '-'))

getIntPair :: IO Pair
getIntPair = do 
    a <- getInt 
    b <- getInt 
    return (a, b)

data Op = Plus | Minus | Times deriving (Show)

type Domain = S.Set Int
type Pair = (Int, Int)
type Variable = (Pair, Domain)
type RemainingValues = M.Map Int Int
type RemainingValues2 = M.Map Int ([Pair], Int)
type Assignment = M.Map Pair [Op]

toVariable :: Pair -> Variable
toVariable (a, b) = 
    ((a, b), domain)
    where domain = S.fromList . fmap (\op -> a `op` b) $ [(+), (-), (*)]

assignLeastRestricting :: Variable -> RemainingValues -> Assignment -> (RemainingValues, Assignment)
assignLeastRestricting (p, ds) rv as = (rv, as)

assignSingle :: Variable -> Int -> Assignment -> Assignment
assignSingle ((a, b), _) i m = 
    if a + b == i then assign Plus
    else if a - b == i then assign Minus
    else assign Times
    where assign v = case (m M.!? p) of
            Nothing -> M.insert p [v] m
            Just vs -> M.insert p (v:vs) m
          p = (a, b)
    
hasSingle :: Variable -> RemainingValues -> Maybe Int
hasSingle (_, ds) rv = 
    fmap (fst . fst) . uncons . filter ((==1) . snd) . fmap (\d -> (d, rv M.! d)) $ S.toList ds

assignSingles :: [Variable] -> RemainingValues -> ([Variable], Assignment) 
assignSingles vs rv = loop vs ([], M.empty)
    where loop [] acc = acc
          loop (x:xs) (xs', as) = 
            case hasSingle x rv of 
                Nothing -> loop xs (x:xs', as)
                Just i -> loop xs (xs', assignSingle x i as) 

constraints :: [Variable] -> RemainingValues
constraints ps = 
    M.fromListWith (+) . (`zip` [1,1..]) $ dv
    where dv = ps >>= (\(_, ds) -> S.toList ds)
 
debugString vs rv vs' as = "vs: " ++ show vs ++ "\nrv: " ++ show rv ++ "\nvs': " ++ show vs' ++ "\nas: " ++ show as

-- findAssignment :: [Pair] -> Maybe Assignment
-- findAssignment ps = 
--     let vs = fmap toVariable ps
--         rv = constraints vs in 
--         loop vs (rv, as)
--         where loop vs (rv, as) = 
--                 let (vs', as') = assignSingles vs rv in
--                 trace (debugString vs rv vs' as) $ 
--                 case vs' of 
--                     []     -> Just as'
--                     v:vs'' -> loop vs'' (assignLeastRestricting v rv as')
            
type VariableMap = M.Map Int [Pair]
type ValuesMap = M.Map Int Int

buildmaps :: [Variable] -> (VariableMap, ValuesMap)
buildmaps = 
    loop (M.empty, M.empty)
    where loop acc [] = acc
          loop ((p, ds):vs) (vr, vl) = 
            


findAssignment :: [Pair] -> Maybe Assignment
findAssignment ps =
    let vs = fmap toVariable ps 
        (varMap, valMap) = buildmaps vs

main = do
    n <- fmap read getLine
    pairs <- replicateM n getIntPair
    case findAssignment pairs of 
        Nothing -> putStrLn "impossible"
        Just as -> print as
    
