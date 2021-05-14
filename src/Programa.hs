module Main where

import System.IO

-- definicao de tipo
type Nota = (String, [Double])

-- definicao de funcao que substitui o tipo
-- nota :: Nota
nota nome n1 n2 = (nome, [n1, n2])

notaVazia = nota "" 0 0

-- consegue ler uma linha
-- passando como argumento a mensagem
-- msg
input msg = do
    putStr msg
    hFlush stdout
    getLine

-- consegue ler um float
inputFloat msg = do
    rawValue <- input msg
    let val = read rawValue :: Double
    return val

-- leitura de notas em modo funcao
lerNota :: IO Nota
lerNota = do
    nome <- input "nome do aluno: "
    if nome == ""
        then return notaVazia
        else do
            nota1 <- inputFloat "Nota 1: "
            nota2 <- inputFloat "Nota 2: "
            -- possivel retorno
            -- return (nome, [nota1, nota2])
            -- abreviado com funcao nota
            return $ nota nome nota1 nota2

lerNotas :: IO [Nota]
lerNotas = do
    nota <- lerNota
    if nota == notaVazia
        then return []
        else do
            notas <- lerNotas
            return $ nota:notas


-- este programa le as notas e imprime em uma tupla
-- renomear para de "main_teste1" para "main" para executar
main_teste1 = do
-- main = do
    nome <- input "nome do aluno: "
    nota1 <- inputFloat "Nota 1: "
    nota2 <- inputFloat "Nota 2: "
    print $ (nome, nota1, nota2)

    -- a dupla pode ter uma lista se for do mesmo valor
    print $ (nome, [nota1, nota2])

main_teste2 = do
-- main = do
    notas <- lerNotas
    print notas

exibirMedias notas = do
-- main = do
    nome <- input "Digite o nome do aluno: "
    if nome == ""
        then putStrLn "Saindo..."
        else do
            let maybeValores = lookup nome notas
            case maybeValores of
                Nothing -> putStrLn $ "Aluno " ++ nome ++ " nao encontrado"
                Just [nota1, nota2] -> do
                    let media = (nota1 + nota2) / 2
                    putStrLn $ "Media: " ++ (show media)
            exibirMedias notas

-- main_final = do
main = do
    let notas <- lerNotas
    exibirMedias notas

-- main_final_reduzido
main = lerNotas >>= exibirMedias