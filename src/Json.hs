{-# LANGUAGE DeriveGeneric #-}

import Data.Aeson
import GHC.Generics
import Data.ByteString.Lazy as DTB

data Pessoa = Pessoa
  { nome :: String
  , idade :: Int
  } deriving (Show, Generic)

instance FromJSON Pessoa
instance ToJSON Pessoa

-- Adiciona uma nova pessoa ao array de pessoas
adicionarPessoa :: Pessoa -> [Pessoa] -> [Pessoa]
adicionarPessoa pessoa pessoas = pessoa : pessoas

-- Salva o array de pessoas em um arquivo JSON
salvarPessoas :: [Pessoa] -> FilePath -> IO ()
salvarPessoas pessoas caminho = DTB.writeFile caminho (encode pessoas)

main :: IO ()
main = do
  jsonData <- DTB.readFile "pessoas.json"
  let pessoas = decode jsonData :: Maybe [Pessoa]
  case pessoas of
    Nothing -> putStrLn "Erro ao ler o arquivo JSON"
    Just pessoas' -> do
      let novaPessoa = Pessoa { nome = "Novo", idade = 30 }
      let pessoasAtualizadas = adicionarPessoa novaPessoa pessoas'
      salvarPessoas pessoasAtualizadas "pessoasAtualizadas.json"
      putStrLn "Pessoas atualizadas salvas com sucesso."
