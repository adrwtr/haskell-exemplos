module Teste where

import Control.Monad

import System.IO


data Pessoa = MkPessoa {
    nome :: String
    , sobrenome :: String
    , cpf :: String
} deriving Show

adriano :: Pessoa
adriano = MkPessoa
    { nome = "Adriano"
    , sobrenome = "Waltrick"
    , cpf = "123456"
    }

showNomePessoa :: Pessoa -> String
showNomePessoa (MkPessoa n s _) = n ++ " " ++ s

data Empresa = MkEmpresa {
    empresa_nome :: String
    , cnpj :: String
} deriving Show

amais :: Empresa
amais = MkEmpresa
    {
        empresa_nome = "Amais Educacao"
        , cnpj = "999"
    }

showEmpresa :: Empresa -> String
showEmpresa (MkEmpresa n c) = "Nome: "
    ++ n
    ++ " - CNPJ: "
    ++ c

data PessoaOuEmpresa
    = TPessoa Pessoa
    | TEmpresa Empresa
    deriving Show

showTiposDePessoa :: PessoaOuEmpresa -> String
showTiposDePessoa tipo = case tipo of
    TPessoa (MkPessoa n s cpf) -> showNomePessoa (MkPessoa n s cpf)
    TEmpresa (MkEmpresa n cnpj) -> showEmpresa (MkEmpresa n cnpj)

minhaPessoa1 :: PessoaOuEmpresa
minhaPessoa1 = TPessoa (MkPessoa "Joao" "da Silva" "33333")

minhaPessoa2 :: PessoaOuEmpresa
minhaPessoa2 = TEmpresa (MkEmpresa "Empresa" "1231231")

minhaPessoa3 :: PessoaOuEmpresa
minhaPessoa3 = TPessoa adriano