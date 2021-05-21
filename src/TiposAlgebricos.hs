module TiposDeDados where

import Control.Monad
import System.IO

data Temperatura = Frio | Quente
    deriving (Eq, Show)

data Estacao = Verao | Outono | Inverno | Primavera
    deriving (Eq, Show)

getTempo :: Estacao -> Temperatura
getTempo Verao = Quente
getTempo Primavera = Quente
getTempo _ = Frio

-- criando um "tipo" do "tipo apelido"
type MeuArray idx value = [(idx, value)]

-- funcao que busca pelo tipo
find :: Eq idx => idx -> MeuArray idx value -> value
find i v = head [value | (x, value) <- v, x == i]


-- Tipo Soma = uniao de diferentes valores
-- admite 4 valores bem especificados
-- todos com a letra maiuscula
data Direcao = Norte | Sul | Leste | Oeste
    deriving Show

type Coordenada = (Int, Int)
type Passo = Coordenada -> Coordenada


-- usando o DATA e o TYPE
para :: Direcao -> Passo
para Norte (x, y) = (x, y+1)
para Sul (x, y)   = (x, y-1)
para Leste (x, y) = (x+1, y)
para Oeste (x, y) = (x-1, y)

caminhar :: [Direcao] -> Passo
caminhar [] n = n
-- caminhar (direcao:resto_lista) coordenada = caminhar resto_lista (para direcao coordenada)
-- o flip eh usado por que o segundo argumento do foldl nao pode ser a lista!
-- como o foldl precisa chamar a funcao para, ele iria enviar coordenada->direcao, mais precisa ser o contrario === foldl = (a -> b -> a) -> a -> [b] -> a
caminhar direcao coordenada = foldl (flip para) coordenada direcao


-- Tipo produto
-- Tipo de dados que possui mais de um tipo dentro dele
data Ponto = MkPonto Double Double
    deriving Show

-- usando o tipo produto
distancia :: Ponto -> Ponto -> Double
distancia (MkPonto x1 y1) (MkPonto x2 y2) =
    sqrt $ (x1 - y1) ^ 2 + (y1 - y2) ^ 2

data Forma = Circulo Ponto Double
    | Retangulo Ponto Double Double
    deriving Show

quadrado :: Ponto -> Double -> Forma
quadrado p l = Retangulo p l l

-- Tipos parametricos
data Ponto2 a = MkPonto2 a a
    deriving Show

-- Maybe e nothing já existem
-- data Maybe a = Nothing | Just a
-- forma de tratar erros

maybeDiv :: Int -> Int -> Maybe Int
maybeDiv _ 0 = Nothing
maybeDiv a b = Just $ (a `div` b)

-- either tbm ja existe
-- Either a b = Left a | Right b
eitherDiv :: Int -> Int -> Either String Int
eitherDiv _ 0 = Left "dividido por zero nao pode"
eitherDiv a b = Right (a `div` b)

data Fuzzy = Verdadeiro | Falso | Pertinencia Double
    deriving (Ord, Eq, Show)

fuzzifica :: Double -> Fuzzy
fuzzifica teste
    | teste <= 0 = Falso
    | teste >= 1 = Verdadeiro
    | otherwise = Pertinencia teste


main :: IO ()
main = do
    putStrLn "hello world"
    print $ getTempo Verao
    print $ getTempo Inverno

    -- tipos genericos
    print $ find 2 [(1, 10), (2, 20), (3, 30)]
    print $ find "adr" [("coisa", 10), ("outro", 20), ("adr", 30)]

    -- usando tipos e datas
    print $ para Norte (0,0)
    print $ show $ caminhar [Leste, Leste, Norte, Norte, Norte] (0, 0)

    -- usando tipo produto
    print $ distancia (MkPonto 3 4) (MkPonto 4 5)

    print $ quadrado (MkPonto 4 4) 5

    print $ (MkPonto2 "ponto1" "ponto2")

    print $ (10 / 0)
    print $ maybeDiv 1 0
    print $ maybeDiv 10 2

    print $ eitherDiv 1 0
    print $ eitherDiv 10 2

    print $ fuzzifica 0
    print $ fuzzifica 1
    print $ fuzzifica 0.1
