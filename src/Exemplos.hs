module Exemplos where

take 50 [1..]

take 50 [5,10..]

[(list) | list <- [1..30], list `mod` 3 /= 0]


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
