module ControleFluxo where

import Control.Monad
import System.IO

-- definicao parcial de operador
soma :: Int -> Int -> Int
soma = (+)

-- definicao parcial de operador
incrementa :: Int -> Int
incrementa = (+1)

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