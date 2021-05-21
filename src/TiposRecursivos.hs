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

-- verifica se o item esta dentro da arvore
contem :: Eq a => Tree a -> a -> Bool
contem (Leaf a) num              = a == num
contem (Node a1 num a2) numteste = num == numteste
    || a1 `contem` numteste
    || a2 `contem` numteste


--Record Type

data Ponto3d = Ponto Double Double Double

-- coordX :: Ponto3d -> Double
coordX (Ponto x _ _ ) = x
coordY (Ponto _ y _ ) = y
coordZ (Ponto _ _ z ) = z

data Ponto3dMelhor = Ponto2 {
      coordX2 :: Double
    , coordY2 :: Double
    , coordZ2 :: Double
} deriving Show


-- arvore outra forma de trabalhar com ela
data Tree2 a =
    Leaf2 a
    | Node2 {
        _rigth :: Tree2 a
        , _value :: a
        , _left :: Tree2 a
    }  deriving Show



main :: IO ()
main = do
    putStrLn "hello world"

    print $ arvore

    print $ contem folha 10
    print $ contem folha 11
    print $ contem arvore 1
    print $ contem arvore 3
    print $ contem arvore 2
    print $ contem arvore 10