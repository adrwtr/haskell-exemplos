module Operadores where

main :: IO ()
main = do
  print (1 + 1)
  print (1 + 1 + 1)
  print (5 * 2)
  print (5 / 2)
  print (5 `mod` 2)
  print (5 / (2 * 2))
  print (5 == 2)
  print (5 /= 2)
  print (5 > 2)
  print (5 < 2)
  print (1 == 1 && 2 == 2)
  print (1 == 1 && 3 == 2)
  print (1 == 1 || 2 == 2)
  print (1 == 1 || 3 == 2)