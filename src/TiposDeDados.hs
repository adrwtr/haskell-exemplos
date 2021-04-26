module TiposDeDados where

-- funcao necessaria para imprimir numeros
printInt :: (Int) -> String
printInt a = show a

printFloat :: (Float) -> String
printFloat a = show a

printBool :: (Bool) -> String
printBool a = show a


-- tipos de dados
nr_numero = 10
vl_float = 12.2
ds_string = "Minha variavel"
sn_boolean = False :: Bool

-- ++ concatena e ($) serve para executar a funcao antes de concatenar
ds_concatenar = ds_string ++ "..." ++ ($) printInt nr_numero

ds_enter = "\n";

arrNumero = [ 10, 20, 50]

arrString = ["Adriano", "Waltrick"]


main :: IO ()
main = do
  putStrLn "hello world"
  putStrLn $ printInt nr_numero
  putStrLn $ printFloat vl_float
  putStrLn $ printBool sn_boolean
  putStrLn ds_string
  putStrLn ds_concatenar
  putStrLn ds_enter

  print arrNumero
  print nr_numero
