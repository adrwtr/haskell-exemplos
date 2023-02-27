module Main (main) where

import Test.Hspec (hspec)

import SomarTest

main :: IO ()
main = hspec $ do
    somarTest
