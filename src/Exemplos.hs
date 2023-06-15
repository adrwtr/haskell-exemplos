module Exemplos where

somar :: Int -> Int -> Int
somar x y = x + y

somar 1 1

-- aplicacao parcial
cur = somar 1

cur 2

:t cur


take 50 [1..]

take 50 [5,10..]

pega3 :: [a] -> [a]
pega3 a = take 3 a

[(list) | list <- [1..30], list `mod` 3 /= 0]


triple :: [Int] -> [Int]
triple = map (\x -> x * 3)

main :: IO ()
main = do
  let numbers = [1, 2, 3, 4, 5]
  let result = triple . reverse . filter even $ numbers
  print result
  print $ app [1, 2, 3, 4, 5]


data Temperatura = Frio | Quente deriving (Eq, Show)

data Estacao = Verao | Outono | Inverno | Primavera deriving (Eq, Show)

temperaturaNaEstacao :: Estacao -> Temperatura
temperaturaNaEstacao Verao = Quente
temperaturaNaEstacao Primavera = Quente
temperaturaNaEstacao _ = Frio

main :: IO ()
main =  do
    print $ temperaturaNaEstacao Verao
    print $ temperaturaNaEstacao Inverno



valor = 10
valor = 20

main :: IO ()
main =  do
    print valor

somaLista :: [Int] -> Int
somaLista [] = 0
somaLista (x:xs) = x + somaLista xs

main :: IO ()
main =  do
    print $ somaLista [1, 2, 3]


quadrados :: [Int] -> [Int]
quadrados = map (^2)

numerosPares :: [Int] -> [Int]
numerosPares = filter even

import Data.List (sort)

concatenaOrdena :: [Int] -> [Int] -> [Int]
concatenaOrdena xs ys = sort (xs ++ ys)

parPositivo :: Int -> Bool
parPositivo = even . abs

import Data.Char (toUpper)

concatenarMaiusculas :: [String] -> String
concatenarMaiusculas = map toUpper . concat


{- # exemplo de declarativo -}
fatorial :: Integer -> Integer
fatorial 0 = 1
fatorial n = n * fatorial (n - 1)



{- # exemplo não declarativo
int calc(fat) {
    if (fat == 0) {
        return 1;
    } else {
        for(fat = 1; n > 1; n = n - 1) {
            fat = fat * n;
        }
        return fat;
    }
}
-}



main = do
  putStrLn "Hello, World!"
  print $ quadrados [1, 2, 3]
  print $ numerosPares [1, 2, 3, 4, 5]
  print $ concatenaOrdena [1, 5, 3] [6, 2, 4]
  print $ parPositivo 2
  print $ concatenarMaiusculas ["a", "b", "c"]




-- data Maybe a = Nothing | Just a

-- Função que divide dois números, retornando um Maybe Double
divide :: Double -> Double -> Maybe Double
divide _ 0 = Nothing
divide x y = Just (x / y)

-- Função que imprime o resultado da divisão
printResult :: Maybe Double -> IO ()
printResult Nothing    = putStrLn "Divisão inválida"
printResult (Just res) = putStrLn ("Resultado: " ++ show res)

-- Exemplo de uso
main :: IO ()
main = do
  putStrLn "Digite dois números:"
  num1 <- readLn
  num2 <- readLn
  let result = divide num1 num2
  printResult result



addTwo :: Int -> Maybe Int
addTwo x = Just (x + 2)

printResult :: Maybe Int -> IO ()
printResult (Just res) = putStrLn ("Resultado: " ++ show res)
printResult Nothing    = putStrLn "Valor inválido"

main :: IO ()
main = do
  let result = Just 3 >>= addTwo >>= addTwo
  printResult result




module TiposDeDados where

import Control.Monad
import System.IO

data Lista a = Vazia | Cons a (Lista a)
-- Cons 1 (Cons 2 (Cons 3 Vazia))

-- arvore
data Tree a = Leaf a | Node (Tree a) a (Tree a)
    deriving Show

arvore :: Tree Int
arvore = Node (Node (Leaf 1) 2 (Leaf 3)) 4 (Node (Leaf 5) 6 (Leaf 7))

folha :: Tree Int
folha = Leaf 10

arvoreNomes = Node (Node (Leaf "Adriano") "João" (Leaf "Jose")) "Pedro" (Node (Leaf "Joaquim") "teste" (Leaf "Joaquim 2"))


-- verifica se o item esta dentro da arvore
contem :: Eq a => Tree a -> a -> Bool
contem (Leaf a) num              = a == num
contem (Node a1 num a2) numteste = num == numteste
    || a1 `contem` numteste
    || a2 `contem` numteste

main :: IO ()
main = do
    putStrLn "hello world"

    print $ arvore

    print $ folha `contem`  10
    print $ contem folha 11

    print $ folha `contem`  10
    print $ arvoreNomes `contem` "Adriano"
    print $ arvoreNomes `contem` "Felipe"