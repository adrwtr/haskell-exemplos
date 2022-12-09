module Teste where

import Control.Monad

import System.IO

newtype Peso = MkPeso
    { propPeso :: Int
    }

newtype Altura = MkAltura
    { propAltura :: Int
    }

getPesoAltura :: Peso -> Altura -> Int
getPesoAltura (MkPeso x) (MkAltura y) = x * y
