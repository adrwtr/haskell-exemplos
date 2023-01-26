module Files where

import System.IO

lerUmArquivo = do
    arquivo <- readFile "/src/src/arquivo.txt"
    putStrLn arquivo

lerUmaLinha = do
    arquivo <- openFile "/src/src/arquivo.txt" ReadMode
    hasLine <- hIsEOF arquivo
    linha <- if not hasLine then hGetLine arquivo else return "vazio"
    putStrLn linha
    hClose arquivo
    putStrLn "done"

-- apaga todo o conteudo anterior
escreverNoArquivo :: [Char] -> Handle -> IO ()
escreverNoArquivo arrString ioEntrada = hPutStrLn ioEntrada arrString

escreverNoFim = do
    arquivo <- openFile "/src/src/arquivo.txt" WriteMode
    escreverNoArquivo "escrito no fim" arquivo
    hClose arquivo


main :: IO ()
main = do
    lerUmArquivo
    lerUmArquivo
    lerUmaLinha
    escreverNoFim
    lerUmArquivo
    -- hClose arquivo