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

    __lazy evaluation__ -> não vai avaliar ou reduzir uma operação
    enquanto ela não for necessaria

    __pattern matching__ - compara valores de um tipo e produz
    resultados baseados em padrões

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

    __eta-reduction__ - simplification of functions over their arguments
    nextInt :: Int -> Int
    nextInt n = add 1 n
    ou
    nextInt :: Int -> Int
    nextInt = add 1

    __Algebraic Data Type__ - ADT - usando os tipos produto e soma

        - __product type__ - combinação de tipos (record)
        data Knight = MkKnight  { health  :: Int, attack :: Int} deriving (Show)
        data Monster = MkMonster  { mhealth  :: Int, mattack :: Int} deriving (Show)

        - __sum type__ - escolha entre tipos (altenativas)
        data PlayerType = Knigth | Monster deriving (Show)

        Com esses dois tipos temos um dominio especificado corretamente
        evitando representações ilegais

    __type aliases__ - podemos criar atalhos para novos tipos
    >>> type IntPair = (Int, Int)

    __Newtype__ - cria um embrulho (wrapper) sobre um ADT
    new type é igual a um __product type__
    >> newtype Peso = MkPeso { xpeso :: Int  }
    >> getPesoAltura :: Peso -> Altura -> Int
    >> getPesoAltura (MkPeso x) (MkAltura y) = x * y

    __Polymorphic data types__ - Parametro paramétrico dentro de um
    novo tipo de dados
    >> data Foo a = MkFoo a
    >> data TreasureChest x = TreasureChest { treasureChestLoot :: x }
    >> howMuchGoldIsInMyChest :: TreasureChest x -> Int -- vai retornar um int
    >> isEnoughDiamonds :: TreasureChest Int -> Int -- aqui o tipo de entrada foi definido

    __Maybe__ - um tipo polimorfico que representa um valor ou nada
    Maybe é um type Constructor, por que não existe um valor Maybe

    __Either__ - vai para um caminho ou para outro
    >> showEither :: Either String Int -> String
    >> showEither (Left msg) = "Left with string: " ++ msg
    >> showEither (Right n) = "Right with number: " ++ show n

    __Typeclass__ - expressa caracteristicas comuns em diferentes tipos de dados
    e podemos usar ele para criar regras que serão usadas na criação de funções
    ou seja, as funções deverão seguir as regras da Typeclass

    É composto por:
        __class__ - definição do typeclass
        __instance__ - cria a definição para o tipo desejado
        __constraints__ - usado na função para determinar as regras
        __ad-hoc polymorphism__ - qndo uma função tem seu comportamento parametrizado
        pelo tipo de dados

    __kinds__ - O tipo que representa os tipos. Ele representa o formato de um tipo.
    Kind *      = tipo primitivo (Int, Bool)
    Kind * -> * = construtor de tipos (Maybe Either)
    Kind * -> Constrait = para constraits em typeclasses

    __functor__ - é uma typeclass - permite alterar o valor ou o tipo de algo que está dentro da "cesta".
    possui o método fmap que precisa ser implementado com o kind * -> *
    Ele também pode ser usado como <$>
    >> fmap show (Just 42)
    >> (+3) <$> (Just 3)

    - INFIX = <$>

    __Applicative__ - é uma functor com os seguintes métodos
        __pure__ adiciona um valor ao contexto
        >> pure True :: Maybe Bool
        >> pure 1 :: Maybe Int

        __<*>__ - extrai uma função parcial de um contexto,
        aplica ela ao argumento e coloca o valor final no contexto novamente

        >> Just (+ 4) <*> Just 7
        >> Just (replicate 3) <*> Just 0

        -- soma3 :: Int ->  Int ->  Int
        -- soma3 a b = a + b
        -- main = print $ Just (soma3 10) <*> Just 1

    - INFIX = <*>

    -- exemplo de applicative + functor
    -- aplica o * a 2 = (* 2) e aplica o 2*3
    (*) <$> (Just 2) <*> (Just 3)

    __Monad__ - aplica o valor a esqueda em uma função a direita
    >> Just 6 >>= half  (aplica 6 ao half, desde que half retorne uma Maybe)
    -- half :: Int -> Maybe Int
    -- half n
    --     | even n = Just (div n 2)
    --     | otherwise = Nothing

    -- somarM :: Int ->  Int ->  Maybe Int
    -- somarM a b = Just (a + b)
    -- aplica o valor wrapped 3 em somarM de 10 e depois channing somarM novamente
    -- main = print $ Just (3) >>= somarM 10 >>= somarM 10

    -- com functor - applicative - monad podemos aplicar funções em uma sequencia de dados ou listas

    Applicatives can be found in many applications:

    ✦ Chaining operations over optional values
    ✦ Parsers
    ✦ Input form validation
    ✦ Concurrent and parallel execution of tasks

-}

{-
Tips a Tricks

specific types start with an uppercase
letter (Int, Bool, Char, etc.)

type variables begin with a
lowercase letter (a, b, el, etc.)
foo :: [a] -> [b] -> [a]

syntax sugar - facilidade de escrever ou abreviar

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
rotate :: Int -> [a] -> [a]
rotate _ [] = []
rotate n arr = drop n $ take ((length arr) + n) $ cycle arr

rewind :: [a] -> [a]
rewind [] = []
rewind arr = head pegaproximo : rewind (tail pegaproximo)
  where
    pegaproximo = rotate (length arr - 1) arr

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


isThird42 :: (Eq a, Num a) => [a] -> Bool
isThird42 [] = False
isThird42 ( _ : _ : x : xs ) = if x == 42 then True else False



{-
Data types

Product - simples data type
-}


data Knight = MkKnight
    { health  :: Int
    , attack :: Int
    , gold :: Int
    } deriving (Show)


data Monster = MkMonster
    { mHealth  :: Int
    , mAttack :: Int
    , mGold :: Int
    } deriving (Show)

fighter1 :: Knight
fighter1 = MkKnight
    { health = 100
    , attack = 10
    , gold = 0
    }

dragon1 :: Monster
dragon1 = MkMonster
    { mHealth = 10
    , mAttack = 10
    , mGold = 10
    }

fight :: Monster -> Knight -> Int
fight monster knight
    | mHealth monster <= 0 = gold knight + mGold monster
    | health knight <= 0 = -1
    | otherwise = fight (MkMonster (mHealth monster - attack knight) (mAttack monster) (mGold monster)) (MkKnight (health knight - mAttack monster) (attack knight) (gold knight))


{-
SUM TYPES

Sum types can be seen as "one-of" data structures.
-}
data MagicType
    = DarkMagic
    | LightMagic
    | NeutralMagic

data Loot
    = Sword Int  -- attack
    | Shield Int  -- defence

woodenSword :: Loot
woodenSword = Sword 2

adamantiumShield :: Loot
adamantiumShield = Shield 3000

acceptLoot :: Loot -> String
acceptLoot loot = case loot of
    Sword _ -> "Thanks! That's a great sword!"
    Shield _ -> "I'll accept this shield as a reward!"


{-
parametric data type
-}

data TreasureChest x = TreasureChest
    { treasureChestGold :: Int
    , treasureChestLoot :: x
    }

showEither :: Either String Int -> String
showEither (Left msg) = "Left with string: " ++ msg
showEither (Right n) = "Right with number: " ++ show n

{--
Typeclasses
--}

{-# LANGUAGE InstanceSigs #-}

class Carro a where
    getCarro :: a -> String

instance Carro Bool where
    getCarro :: Bool -> String
    getCarro True = "True Car"
    getCarro False = "False Car"

instance Carro Int where
    getCarro :: Int -> String
    getCarro i = case i of
        0 -> "Carro não anda"
        _ -> printInt i ++ ".0 car"

printInt :: (Int) -> String
printInt a = show a

revealCar :: (Carro a, Show a) => a -> String
revealCar x = "As propriedades do carro sao: " ++ (getCarro x)

-- main = do
--    putStrLn "Hello, World!"
--    putStrLn $ revealCar (2 :: Int)
--    putStrLn $ revealCar (True :: Bool)



data DiasDaSemana
    = Segunda -- 0
    | Terca
    | Quarta
    | Quinta
    | Sexta -- 4
    | Sabado
    | Domingo
    deriving (Show, Eq, Ord)

isWeekend :: DiasDaSemana -> Bool
isWeekend a
    | a == Sabado = True
    | a == Domingo = True
    | otherwise = False

nextDay :: DiasDaSemana -> DiasDaSemana
nextDay Domingo = Segunda
nextDay a = toEnum ((fromEnum a) + 1)

daysToParty :: DiasDaSemana -> Int
daysToParty Sexta = 0
daysToParty Sabado = 2 + daysToParty Segunda
daysToParty Domingo = 1 + daysToParty Segunda
-- o /= Sexta é um lambda infix -- cria a lista de a até sexta, separa num array e conta qntos tem
daysToParty a = length $ takeWhile ( /= Sexta) [a .. Sexta]

instance Enum DiasDaSemana where
  toEnum :: Int -> DiasDaSemana
  toEnum 0 = Segunda
  toEnum 1 = Terca
  toEnum 2 = Quarta
  toEnum 3 = Quinta
  toEnum 4 = Sexta
  toEnum 5 = Sabado
  toEnum 6 = Domingo

  fromEnum :: DiasDaSemana -> Int
  fromEnum Segunda  = 0
  fromEnum Terca    = 1
  fromEnum Quarta   = 2
  fromEnum Quinta   = 3
  fromEnum Sexta    = 4
  fromEnum Sabado   = 5
  fromEnum Domingo  = 6

daysToPartyInstance :: DiasDaSemana -> Int
daysToPartyInstance day = fromEnum (Sexta :: DiasDaSemana) - fromEnum day



{-
functors aplicatives monads
-}
data Secret e a
    = Trap e
    | Reward a
    deriving (Show, Eq)

instance Functor (Secret e) where
    fmap :: (a -> b) -> Secret e a -> Secret e b
    fmap _ (Trap e) = Trap e
    fmap f (Reward a) = Reward (f a)

-- example
addOneGold :: (Integral a, Num a) => (Secret e a) -> (Secret e a)
addOneGold (Trap e) = Trap e
addOneGold (Reward a) = Reward (a + 1)

addToChest :: (Integral a, Num a, Num e) => a -> (Secret e a)
addToChest a
    | a == 0    = (Trap 0)
    | otherwise = Reward a

-- addOneGold (Reward 1)
-- addOneGold $ Reward 1
-- fmap (addToChest) (Reward 1)


instance Applicative (Secret e) where
    pure :: a -> Secret e a
    pure = Reward
    (<*>) :: Secret e (a -> b) -> Secret e a -> Secret e b
    (Trap a) <*> _ = Trap a
    _ <*> (Trap a) = Trap a
    (Reward f) <*> i = fmap f i

-- tests
secret1 = Trap "you die"
secret2 = Reward 10
secret3 = Reward 20

-- fmap (+10) secret1

-- 50
-- fmap (+40) secret2

-- 20
-- Reward (+10) <*> Reward 10

instance Monad (Secret e) where
    (>>=) :: Secret e a -> (a -> Secret e b) -> Secret e b
    (Trap c) >>= f = Trap c
    (Reward c) >>= f = f c

test :: Int -> Secret Int Int
test n
    | n == 1 = Trap 1
    | otherwise = Reward (n + 1)

-- test
-- Trap 11 >>= test
-- Reward 11 >>= test
-- Reward 11 >>= test >>= test




data List a
    = Empty
    | Cons a (List a)
    deriving (Show)

instance Functor List where
    fmap :: (a -> b) -> List a -> List b
    fmap _ Empty = Empty
    fmap f (Cons a (blist)) = Cons (f a) (fmap f blist)


list1 = Empty
list2 = Cons 10 (Cons 20 Empty)
list3 = Cons 10 (Cons 20 (Cons 30 Empty))

-- fmap (+10) list3
-- Cons 20 (Cons 30 (Cons 40 Empty))


list4 = Cons (+5) Empty
list5 = Cons (+5) (Cons (+6) Empty)
list6 = Cons (+1) (Cons (+2) (Cons (+3) Empty))
list7 = Cons 1 (Cons 2 (Cons 3 Empty))

combineList :: List a -> List a -> List a
combineList Empty l1 = l1
combineList l1 Empty = l1
combineList (Cons x xs) l2 = Cons x (combineList xs l2)

instance Applicative List where
    pure :: a -> List a
    pure a = Cons a Empty
    (<*>) :: List (a -> b) -> List a -> List b
    Empty <*> _ = Empty
    _ <*> Empty = Empty
    -- (Cons f l) <*> i = fmap f i
    -- (Cons f (Cons l emp)) <*> i = fmap l i
    (Cons f emp) <*> i = combineList (fmap f i) (emp <*> i)

-- list6 <*> list7


flattenList :: List (List a) -> List a
flattenList Empty = Empty
flattenList (Cons x xs) = combineList x (flattenList xs)

instance Monad List where
    (>>=) :: List a -> (a -> List b) -> List b
    list1 >>= func = flattenList (fmap func list1)

addOneOnList :: (Integral a, Num a) => a -> List a
addOneOnList n = Cons (n + 1) Empty

listC = Cons list2 Empty

-- exemplo de uso
-- list2 >>= addOneOnList
-- list3 >>= addOneOnList
-- list3 >>= addOneOnList >>= addOneOnList
