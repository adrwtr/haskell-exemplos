
module Teste where

import Control.Monad
import System.IO

data Lista a = Vazia | Cons a (Lista a)
-- Cons 1 (Cons 2 (Cons 3 Vazia))

-- arvore
data Tree a = Leaf a | Node (Tree a) a (Tree a)
    deriving Show

arvore :: Tree Int
arvore = Node (Node (Leaf 1) 2 (Leaf 3)) 4 (Node (Leaf 5) 6 (Leaf 7))

arvoreNomes = Node (Node (Leaf "Adriano") "João" (Leaf "Jose")) "Pedro" (Node (Leaf "Joaquim") "teste" (Leaf "Joaquim 2"))

folha :: Tree Int
folha = Leaf 10

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
    print $ arvoreNomes `contem` "Adriano"
    print $ arvoreNomes `contem` "Pedro 2"
    -- print $ contem folha 11
    -- print $ contem arvore 1
    -- print $ contem arvore 3
    -- print $ contem arvore 2
    -- print $ contem arvore 10