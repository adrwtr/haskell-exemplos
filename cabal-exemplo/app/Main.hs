{-# LANGUAGE DeriveGeneric #-}

module Main where

import System.IO

-- cabal install aeson
import Data.Aeson
import GHC.Generics
import Data.ByteString.Lazy as DTB

-- data types

data Pessoa = Pessoa
  { nome :: String
  , idade :: Int
  } deriving (Show, Generic)


-- instances

instance FromJSON Pessoa
instance ToJSON Pessoa

-- const
arquivoPath :: String
arquivoPath = "pessoas.json"

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

-- cadastro
labelCadastroPessoa :: String
labelCadastroPessoa = "Iniciando cadastro:\n"


-- imprime todos
labelImprimeTodos :: String
labelImprimeTodos = "********************\nListando todos os cadastros:\n"

-- procurar
labelProcurar :: String
labelProcurar = "********************\nProcurar cadastro:\n"


-- helpers

-- consegue ler valores do teclado
lerTeclado :: String -> IO String
lerTeclado msg = do
    System.IO.putStr msg
    hFlush stdout
    getLine

-- consegue ler do teclado e transformar em um int
lerTecladoInt :: String -> IO Int
lerTecladoInt msg = do
    mString <- lerTeclado msg
    let intval = read mString :: Int
    return intval

--------------------
-- logica de negocio


-- Salva o array de pessoas em um arquivo JSON
salvarPessoas :: [Pessoa] -> FilePath -> IO ()
salvarPessoas pessoas caminho = DTB.writeFile caminho (encode pessoas)

-- Adiciona uma nova pessoa ao array de pessoas
adicionarPessoa :: Pessoa -> [Pessoa] -> [Pessoa]
adicionarPessoa pessoa pessoas = pessoas ++ [pessoa]

pegarPessoas :: FilePath -> IO [Pessoa]
pegarPessoas fpath = do
    jsonData <- DTB.readFile fpath
    let pessoas = decode jsonData :: Maybe [Pessoa]
    case pessoas of
        Nothing -> return []
        Just pessoas' -> do
            return pessoas'

cleanPessoaPrint :: [Pessoa] -> IO ()
cleanPessoaPrint [] = return ()
cleanPessoaPrint (x:xs) = do
    putStrLn $  "Nome: " ++ (nome x) ++ "\nIdade: " ++ show (idade x) ++ "\n"
    cleanPessoaPrint xs



------------------
-- fluxo programa

-- cadastra uma pessoa no arquivo
cadastrarPessoa :: String -> IO ()
cadastrarPessoa filePath = do
    putStrLn labelCadastroPessoa
    nome <- lerTeclado "Informe o nome da pessoa:"
    idade <- lerTecladoInt "Informe a idade:"
    let novaPessoa = Pessoa { nome = nome, idade = idade }
    putStrLn $ show novaPessoa
    arrPessoas <- pegarPessoas filePath
    let arrPessoas' = adicionarPessoa novaPessoa arrPessoas
    salvarPessoas arrPessoas' arquivoPath
    return ()

-- le todas as pessoas do arquivo
exibirTodos :: String -> IO ()
exibirTodos filePath = do
    putStrLn labelImprimeTodos
    arrPessoas <- pegarPessoas filePath
    cleanPessoaPrint arrPessoas
    return ()

procurar :: String -> IO ()
procurar filePath = do
    putStrLn labelProcurar
    id <- lerTecladoInt "Informe o código:"
    arrPessoas <- pegarPessoas filePath
    cleanPessoaPrint $ [arrPessoas !! id]
    return ()

-- main

main = do
    putStrLn menuBoasVindas
    putStrLn menuPrincipal
    opcaoMenu <- lerTecladoInt "Informe uma opção:"
    case opcaoMenu of
        1 -> do {
            cadastrarPessoa (arquivoPath) >> main
        }
        2 -> do {
            procurar (arquivoPath) >> main
        }
        3 -> do {
            exibirTodos (arquivoPath) >> main
        }
        4 -> putStrLn "Painel:"
        5 -> putStrLn "Saindo..."
        otherwise -> main



--     nome <- input "nome do aluno: "
--     nota1 <- inputFloat "Nota 1: "
--     nota2 <- inputFloat "Nota 2: "
--     print $ (nome, nota1, nota2)

--     -- a dupla pode ter uma lista se for do mesmo valor
--     print $ (nome, [nota1, nota2])
