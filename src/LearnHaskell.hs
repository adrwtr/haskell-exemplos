module LearnHaskell where

{-
No Haskell nos temos
    __expressions__
    que são __evaluated__ (or reduced)

    é uma linguagem __compiled__
    - Parsing  +------> Compilation +-----> Executable

    é uma __strongly-typed__ language

    e é  __statically-typed__ definindo os tipos em tempo de compilação

    tem __type inference__ para descobrir tipos

    __indentation-__ and __layout-sensitive__ language

    __parametric polymorphism__ -> trabalha com listas polimorficas
    - de qualquer tipo que será inferido

    __lazy evaluation__ -> doesn't evaluate expressions when not needed
-}

{-
Tips a Tricks

specific types start with an uppercase
letter (Int, Bool, Char, etc.)

type variables begin with a
lowercase letter (a, b, el, etc.)
foo :: [a] -> [b] -> [a]

syntax sugar - facilidade de escrever ou abreviar

__pattern matching__ - match on different values of a type
and produce results based on patterns

__hole__ - symbol "_" (underscore) is called __hole__,
and it is used when we don't care about the value of a variable

The canonical naming scheme for such patterns is `(x:xs)`
where x is the first element of the list, and xs — rest of the list

__higher-order functions__ - qndo uma função recebe outra como argumento
 ✲ You can pass functions as arguments
 ✲ You can return functions as results
 ✲ You can compose functions easily to create new functions
 ✲ You can have lists of functions


__lambdas__ (or anonymous functions) - funções sem nome
>>> map (\x -> x + 3) [0..5]
[3,4,5,6,7,8]

__apply functions partially__ - aplicar funções parcialmente

__eta-reduction__ - simplification of  functions over their arguments
nextInt :: Int -> Int
nextInt n = add 1 n
ou
nextInt :: Int -> Int
nextInt = add 1
-}

{-
Para descobrir o tipo das coisas
>>> :t False

>>> :t 42
42 :: Num a => a

>>> :t (True, 'x')
(True, 'x') :: (Bool, Char)

Or you can even pass the "+d" option to the ":t"
command to see a simpler type.

>>> :t +d (+)
(+) :: Integer -> Integer -> Integer
-}


{-
Exemplo de função
>>> squareSum 3 4
49
-}
squareSum :: Int -> Int -> Int
squareSum x y = (x + y) * (x + y)

{-
Exemplo de como carregar arquivo
ghci> :l src/Chapter1.hs
ghci> :r <-- para recarregar o fonte e recompilar
-}


{-
Exemplo de if_then_else

closestToZero 10 5
5
-}
closestToZero :: Int -> Int -> Int
closestToZero x y = if abs x < abs y then x else y

{-
Exemplo de condições multiplas

sign (-5)
-1
-}
sign :: Int -> Int
sign n
    | n < 0 = (-1)
    | n == 0 = 0
    | otherwise = 1

evalOperation :: Char -> Int -> Int -> Int
evalOperation op x y = case op of
    '+' -> x + y
    '-' -> x - y
    '*' -> x * y
    '/' -> div x y
    _ -> 0

{-
Exemplo de let-in

halfAndTwice 2
-}
halfAndTwice :: Int -> (Int, Int)
halfAndTwice n =
    let halfN = div n 2
        twiceN = n * 2
    in (halfN, twiceN)

{-
Exemplo de where

pythagoras 2 2
-}
pythagoras :: Double -> Double -> Double
pythagoras a b = square a + square b
  where
    square :: Double -> Double
    square x = x ^ 2

{-
Exemplo simples de recursão

firstDigit 5623
5
-}
firstDigit :: Int -> Int
firstDigit n = if n < 10
    then n
    else firstDigit (n `div` 10)

{-
Importando partes de uma biblioteca
use Hoogle para encontrar novas bibs

import Data.List (sort)
-}

{-
Listas

[3, 5, 1]
[False, True]
[]

>>> :t [True, False]
>>> :t (++) -- append two lists
>>> :t (:) -- Prepend an element at the beginning of a list:

Reverse a list:
reverse :: [a] -> [a]

Take first N elements of a list:
>>> :t take

Create a list from N same elements:
>>> :t replicate

Split a string by line breaks:
>>> :t lines

Join a list of strings with line breaks:
>>> :t unlines

>>> [10, 2] ++ [3, 1, 5]
[10,2,3,1,5]

>>> [] ++ [1, 4]  -- [] is an empty list
[1,4]

>>> 3 : [1, 2]
[3,1,2]

>>> 4 : 2 : [5, 10]  -- prepend multiple elements
[4,2,5,10]

>>> [1 .. 10]  -- list ranges
[1,2,3,4,5,6,7,8,9,10]

>>> [10 .. 1]
[]

>>> [10, 9 .. 1]  -- backwards list with explicit step
[10,9,8,7,6,5,4,3,2,1]

>>> length [4, 10, 5]  -- list length
3

>>> replicate 5 True
[True,True,True,True,True]

>>> take 5 "Hello, World!"
"Hello"

>>> drop 5 "Hello, World!"
", World!"

>>> zip "abc" [1, 2, 3]  -- convert two lists to a single list of pairs
[('a',1),('b',2),('c',3)]

>>> words "Hello   Haskell     World!"  -- split the string into the list of words
["Hello","Haskell","World!"]
-}

{-
Pattern Match examples
-}
isEmpty :: [a] -> Bool
isEmpty [] = True
isEmpty _ = False

sumThree :: [Int] -> Int
sumThree [x, y, z] = x + y + z
sumThree _ = 0

onlyTwoElements :: [a] -> Bool
onlyTwoElements [_, _] = True
onlyTwoElements _ = False

-- return the first element of the list or default if the list is empty
headOrDef :: a -> [a] -> a
headOrDef def [] = def
headOrDef _ (x:_) = x

-- check if the first list element is zero
firstIsZero :: [Int] -> Bool
firstIsZero (0:_) = True
firstIsZero _ = False

-- check that a list has at least two elements
atLeastTwo :: [a] -> Bool
atLeastTwo (_ : _ : _) = True
atLeastTwo _ = False


{-
Recussão
-}

-- contar até chegar a zero

{-
The pattern of having a recursive helper function is called "Recursive go":
* https://kowainik.github.io/posts/haskell-mini-patterns#recursive-go
-}

divToZero :: Int -> Int
divToZero n = go 0 n
  where
    go :: Int -> Int -> Int
    go acc 0 = acc
    go acc n = go (acc + 1) (div n 2)

-- list length
len :: [a] -> Int
len [] = 0
len (_:xs) = 1 + len xs

-- add 10 to every number of a list
addEvery10 :: [Int] -> [Int]
addEvery10 [] = []
addEvery10 (x:xs) = (x + 10) : addEvery10 xs

{-
Higher-order functions

>>> :t filter
filter :: (a -> Bool) -> [a] -> [a]
>>> :t map
map :: (a -> b) -> [a] -> [b]

And few usage examples of those functions:

>>> filter even [1..10]  -- keep only even elements in the list
[2,4,6,8,10]
>>> map not [True, False, True]  -- maps the 'not' function over each element of the given list
[False,True,False]
-}

{-
Partial functions

>>> map (div 10) [1 .. 10]
[10,5,3,2,2,1,1,1,1,1]

You can apply operators partially too!

>>> filter (< 3) [2, 1, 3, 4, 0, 5]
[2,1,0]
>>> map (* 2) [1..5]
[2,4,6,8,10]
-}

smartReplicate :: [Int] -> [Int]
smartReplicate = concatMap (\x -> replicate x x)

contains :: Int -> [[Int]] -> [Int]
contains _ [] = []
contains _ [[]] = []
contains b (x:xs) = if (elem b x) == True
    then x ++ contains b xs
    else contains b xs

{-
Eta-reduction
-}

divideTenBy :: Int -> Int
divideTenBy = div 10

-- TODO: type ;)
listElementsLessThan :: Int -> [Int] -> [Int]
listElementsLessThan x = filter (< x)

-- Can you eta-reduce this one???
pairMul :: [Int] -> [Int] -> [Int]
pairMul = zipWith (*)


{-
Lazy evaluation

take 4 [0 ..]
[0,1,2,3]

take 5 (repeat 0)
[0,0,0,0,0]
-}
