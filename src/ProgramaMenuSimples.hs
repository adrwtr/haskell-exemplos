module Main where

import System.IO

-- mensagens

-- mensagem inicial do programa
menuBoasVindas :: String
menuBoasVindas = "\n*****************************\n"
    ++ "Bem vindo ao CRUD HASKELL 1.0\n"
    ++ "*****************************\n"
    ++ "\n"

-- menu do programa
menuPrincipal :: String
menuPrincipal = "Escolha uma das opções baixo:\n"
    ++ "1. Cadastrar pessoa\n"
    ++ "2. Procurar por uma pessoa\n"
    ++ "3. Exibir todos os cadastros\n"
    ++ "4. Painel\n"
    ++ "5. Sair\n\n"

-- helpers

-- consegue ler valores do teclado
lerTeclado :: String -> IO String
lerTeclado msg = do
    putStr msg
    hFlush stdout
    getLine

-- consegue ler do teclado e transformar em um int
lerTecladoInt :: String -> IO Int
lerTecladoInt msg = do
    mString <- lerTeclado msg
    let intval = read mString :: Int
    return intval



main = do
    putStrLn menuBoasVindas
    putStrLn menuPrincipal
    opcaoMenu <- lerTecladoInt "Informe uma opção:"
    case opcaoMenu of
        1 -> putStrLn "Cadastrar Pessoa:"
        2 -> putStrLn "Procurar:"
        3 -> putStrLn "Exibir Todos:"
        4 -> putStrLn "Painel:"
        5 -> putStrLn "Saindo..."
        otherwise -> main

--     nome <- input "nome do aluno: "
--     nota1 <- inputFloat "Nota 1: "
--     nota2 <- inputFloat "Nota 2: "
--     print $ (nome, nota1, nota2)

--     -- a dupla pode ter uma lista se for do mesmo valor
--     print $ (nome, [nota1, nota2])
