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

tabuadaNumero :: (Ord a, Num a, Show a) => a -> String
tabuadaNumero 10 = "0"
tabuadaNumero n = tabuadaNumero (n+1) ++ printNumero 1 (n+1)

printNumero :: (Ord a, Num a, Show a) => a -> a -> String
printNumero n1 10 = (show n1) ++ " * " ++ (show 10) ++ " = " ++ show (n1) ++ "\n"
printNumero n1 n2 = printNumero n1 (n2+1) ++ (show n1) ++ " * " ++ (show n2) ++ " = " ++ (show 10) ++ "\n"


printTabuada :: (Ord a, Num a, Show a) => a -> a -> String
printTabuada n1 n2 = (show n1) ++ " * " ++ (show n2) ++ " = " ++ show (n1 * n2) ++ "\n"

printLinha1 :: (Num a, Show a) => a -> String
printLinha1 n1 = "\nTabuada de: " ++ (show n1) ++ "\n"

multiplica :: (Ord a, Num a, Show a) => a -> a -> String
multiplica const1 1 = printLinha1 const1 ++ printTabuada const1 1 ++ (multiplica const1 (2))
multiplica const1 10 = printTabuada const1 10
multiplica const1 var1 = printTabuada const1 var1 ++ multiplica const1 (var1 + 1)

tabuada :: (Ord a, Num a, Show a) => a -> String
tabuada 5 = multiplica 5 1
tabuada n = multiplica n 1 ++ tabuada (n+1)

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




-- // Escreva um programa que desenhe uma
-- // piraide de asteriscos (*). A saida do seu programa
-- // deve seguir o padrao abaixo:
-- //   *
-- //  ***
-- // *****
-- //*******

-- $nr_tamanho = 4;
-- $nr_espacos = $nr_tamanho;
-- $nr_estrelas = 0;

-- while ($nr_tamanho > 0) {
--    $nr_espacos = $nr_espacos - 1;
--    $nr_estrelas = $nr_estrelas + 1;

--    for ($i = 0; $i < $nr_espacos; $i++) {
--       echo " ";
--    }

--    for ($i = 0; $i < $nr_estrelas; $i++) {
--       echo "*";
--    }

--    if ($nr_estrelas > 1) {
--       for ($i = 1; $i < $nr_estrelas; $i++) {
--          echo "*";
--       }
--    }

--    echo "\n";

--    $nr_tamanho = $nr_tamanho - 1;
-- }