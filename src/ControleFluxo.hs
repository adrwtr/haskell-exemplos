module ControleFluxo where

import Control.Monad
import System.IO

-- if simples
testeIf :: (Ord a) => a -> a -> String
testeIf a b = if a < b
    then "a eh menor que b"
    else "a eh maior que b"

-- case simples
testeCaso :: (Eq a, Num a) => a -> String
testeCaso teste
    | teste == 1   = "eh um"
    | teste == 5   = "eh cinco"
    | teste == 10  = "eh 10"
    | otherwise    = "nao sei"

arrNomes = ["Adriano", "Joao", "Pedro", "Simão"]

-- imprime uma string formatada da tabuada entre 2 numeros
printTabuada :: (Ord a, Num a, Show a) => a -> a -> String
printTabuada n1 n2 = (show n1) ++ " * " ++ (show n2) ++ " = " ++ show (n1 * n2) ++ "\n"

-- primime a primeira linha da tabuada
printLinha1 :: (Num a, Show a) => a -> String
printLinha1 n1 = "\nTabuada de: " ++ (show n1) ++ "\n"

-- realiza a tabuada de um numero até 10
multiplica :: (Ord a, Num a, Show a) => a -> a -> String
multiplica const1 1 = printLinha1 const1 ++ printTabuada const1 1 ++ (multiplica const1 (2))
multiplica const1 10 = printTabuada const1 10
multiplica const1 var1 = printTabuada const1 var1 ++ multiplica const1 (var1 + 1)

-- imprime a tabuada de um numero ateh 5
tabuada :: (Ord a, Num a, Show a) => a -> String
tabuada 5 = multiplica 5 1
tabuada n = multiplica n 1 ++ tabuada (n+1)



-- algoritmo de resolucao do problem da arvore de natal
espacoAntes :: (Ord a, Num a, Show a) => a -> a -> String
espacoAntes n total
    | n < total = " " ++ espacoAntes (n+1) total
    | otherwise = ""

-- algoritmo de resolucao do problem da arvore de natal
estrela :: (Ord a, Num a, Show a) => a -> a -> String
estrela n total
    | n < total = "*" ++ estrela (n+1) total
    | otherwise = ""

-- algoritmo de resolucao do problem da arvore de natal
loopArvore :: (Ord a, Num a, Show a) => a -> String
loopArvore 4 = estrela 0 4 ++ "\n"
loopArvore n = espacoAntes 0 (4 - n) ++ estrela 0 n ++ "\n" ++ loopArvore (n+1)


main :: IO ()
main = do
    print $ testeIf 10 20
    print $ testeIf 100 20
    print $ testeCaso 1
    print $ testeCaso 10
    print $ testeCaso 20
    print [1..10]

    -- imprimindo valores de array com lambda
    forM arrNomes (\a -> do
        putStrLn $ show a
        )

    putStrLn "Fim "

    -- Escreva um programa que imprime na tela os numeros
    -- de 1 a 30 exceto os numeros
    -- múltiplos de 3
    -- list compreension
    print [(list) | list <- [1..30], list `mod` 3 /= 0]

    -- // Escreva um programa que imprime a tabuada
    -- // dos numeros de 3 a 5 de acordo com o padrao
    putStr $ tabuada 3

    -- putStr $ espacoAntes 2 10
    -- putStr $ estrela 1 2
    -- putStr $ estrela 1 3
    -- putStr $ estrela 1 4
    putStr $ loopArvore 1