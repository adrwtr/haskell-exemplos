{-# OPTIONS_GHC -Wno-type-defaults #-}

module SomarTest
    ( somarTest
    ) where

import Test.Hspec (Spec, describe, it, shouldBe)

import Somar

somarTest :: Spec
somarTest = describe "spec for somar " $ do
    meuTestSomar
    outroTest

meuTestSomar :: Spec
meuTestSomar = describe "sub-spec" $ do
    describe "soma 2 valores: " $ do
        it "retorna a soma de 2 e 2" $ minhaSoma 2 2  `shouldBe` 4
        it "retorna a soma de 2 e 3" $ minhaSoma 2 3  `shouldBe` 5
        it "retorna a soma de 2 e 3" $ minhaSoma 2 4 `shouldBe` 1

outroTest :: Spec
outroTest = describe "sub-spec" $ do
    it "outro teste" $ minhaSoma 2 2  `shouldBe` 4