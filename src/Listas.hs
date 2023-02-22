module ControleFluxo where

import Control.Monad
import System.IO

-- ajuda do algoritmo de ordenacao
inserirNaLista :: Int -> [Int] -> [Int]
inserirNaLista a [] = [a]
inserirNaLista num (x:xs)
    | num <= x   = num:x:xs
    | otherwise = x : inserirNaLista num xs

-- algoritmo de ordenacao (sort) recursivo
iSort :: [Int] -> [Int]
iSort []     = []
iSort (x:xs) = inserirNaLista x (iSort xs)


-- soma todos os valores da lista
somar :: [Int] -> Int
somar []     = 0
somar (x:xs) = x + somar xs


-- inverte a lista
reverse1 :: [Int] -> [Int]
reverse1 [] = []
reverse1 (x:xs) = reverse1 xs ++ [x]

-- retorna o primeiro elemento da lista
primeiro :: [Int] -> Int
primeiro [] = error "lista vazia"
primeiro (x:xs) = x

-- retorna o menor valor e o maior valor
menorMaior :: [Int] -> (Int, Int)
menorMaior [] = (0, 0)
menorMaior lista = (head $ iSort lista, head $ reverse $ iSort lista)

-- retorna o menor valor e o maior valor
menorMaior2 :: [Int] -> (Int, Int)
menorMaior2 [] = (0, 0)
menorMaior2 lista = let sorted = iSort lista
    in let reversed = reverse sorted
    in (head sorted, head reversed)

-- funcao que soma uma lista de tuplas
somaPares :: [(Int, Int)] -> Int
somaPares [] = 0
somaPares ((a,b):xs) = a + b + somaPares xs

-- funcao que soma uma lista de tuplas
somaPares2 :: [(Int, Int)] -> Int
somaPares2 [] = 0
somaPares2 (x:xs) = a + b + somaPares xs
    where (a, b) = x

-- funcao de alta ordem que recebe uma lista e transforma ela
-- (Int -> Int) <-- é a funcao
mapInt :: (Int -> Int) -> [Int] -> [Int]
mapInt f []     = []
mapInt f (x:xs) = f x : mapInt f xs

times2 :: Int -> Int
times2 n = 2 * n

times3 :: Int -> Int
times3 n = 3 * n

dobra :: [Int] -> [Int]
dobra list = mapInt times2 list

triplo :: [Int] -> [Int]
triplo list = mapInt times3 list

tamanho :: [Int] -> Int
tamanho [] = 0
tamanho (x:xs) = 1 + tamanho xs

tamanho2 :: [tipoQualquer] -> Int
tamanho2 [] = 0
tamanho2 (x:xs) = 1 + tamanho2 xs


main :: IO ()
main = do
    let lista1 = [3, 2, 5, 10, 11, 1]
    print lista1
    -- segundo elemento da lista
    print $ lista1 !! 2
    print $ iSort lista1
    print $ reverse lista1
    print $ reverse1 lista1
    print $ somar lista1
    print $ primeiro lista1
    print $ menorMaior lista1
    print $ menorMaior2 lista1

    let listaPar = [(2, 1), (3, 10)]
    print $ somaPares listaPar
    print $ somaPares2 listaPar

    print $ mapInt times2 lista1
    print $ mapInt times3 lista1

    print $ dobra lista1
    print $ triplo lista1

    print $ tamanho lista1
    print $ tamanho2 lista1

    -- deve retornar 5
    print $ tamanho2 "teste"
