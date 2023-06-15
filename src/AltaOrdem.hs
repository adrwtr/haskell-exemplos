module ControleFluxo where

import Control.Monad
import System.IO

-- definicao parcial de operador
soma :: Int -> Int -> Int
soma = (+)

-- definicao parcial de operador
incrementa :: Int -> Int
incrementa = (+1)

-- exemplo para composicao de funcao
aplicaQuatroX :: (a -> a) -> a -> a
aplicaQuatroX f a = (f . f . f . f) a

pega3 :: [a] -> [a]
pega3 a = take 3 a

apaga3 :: [a] -> [a]
apaga3 a = drop 3 a

hiorder :: (Int -> [a] -> [a]) -> [a] -> [a]
hiorder _ [] = []
hiorder f a = f 3 $ a

main :: IO ()
main = do
    print $ (+) 2 3
    print $ soma 2 3
    print $ incrementa 10
    print $ map (+1) [1, 2, 3]
    print $ map (<=2) [1, 2, 3]
    -- adiciona
    print $ foldr (+) 0 [1, 2, 3, 4]

    -- concatena
    print $ foldr (++) [] ["alo", " ", "mundo"]

    -- filtra
    print $ filter (>10) [1, 2, 10, 20, 30, 40, 50]

    -- filtra removendo espaco
    print $ filter (/= ' ') "alo mundo - estamos aqui"

    -- pega ateh chegar no predicado
    print $ takeWhile (/= ' ') "alo mundo - estamos aqui"

    -- pega tudo depois do predicado
    print $ dropWhile (/= ' ') "alo mundo - estamos aqui"

    -- lambdas
    print $ map (\(x,y) -> x + y) [(1, 2), (3,4), (5,6)]

    print $ filter (\xs -> length xs > 3) ["adriano", "haslkel", "ma", "Lu", "co"]

    print $ foldr (\x y -> x + y) 0 [1, 2, 3]

    -- composicao de funcao
    print $ aplicaQuatroX (\x -> x+1) 1

    print $ hiorder drop "hello world"
    print $ hiorder take "hello world"
