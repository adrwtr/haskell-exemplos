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

-- tabuadaNumero :: (Eq a, Num a) => a -> IO (Int)
-- tabuadaNumero n1 = do
--     if n1 == 10
--         then do
--             let val = read 10 :: Int
--             return val
            -- print $ n1 * tabuadaNumero (n1 + 1)
        -- else do print $ n1 * 10


-- tabuada n1 n2
--     if n1 < n2
--         then do
--             print $ tabuadaNumero n1
--             tabuada (n1 + 1) n2
funcaoImprimir :: (Ord a, Num a, Show a) => a -> a -> String
funcaoImprimir const1 var1 = (show const1) ++ " * " ++ (show var1) ++ " = " ++ show (const1 * var1) ++ "\n"


funcaoInterna :: (Ord a, Num a, Show a) => a -> a -> String
funcaoInterna const1 1 = "\nTabuada de: " ++ (show const1) ++ "\n" ++ funcaoImprimir const1 1 ++ (funcaoInterna const1 (2))
funcaoInterna const1 10 = funcaoImprimir const1 10
funcaoInterna const1 var1 = funcaoImprimir const1 var1 ++ funcaoInterna const1 (var1 + 1)

funcaoExterna :: (Ord a, Num a, Show a) => a -> String
funcaoExterna 5 = funcaoInterna 5 1
funcaoExterna n = funcaoInterna n 1 ++ funcaoExterna (n+1)

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
    -- tabuadaNumero 3
    -- putStr $ tabuadaNumero 1
    putStr $ funcaoExterna 3







-- for ($i = 3; $i <= 5; $i++) {
--    echo "tabuada de " . $i;
--    echo $ds_enter;

--    for ($a = 0; $a <= 10; $a++) {
--       echo $i . " * " . $a . " = " . $i * $a;
--       echo $ds_enter;
--    }
-- }


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