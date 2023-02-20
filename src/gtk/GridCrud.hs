module Main where

{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE GeneralisedNewtypeDeriving #-}


import Control.Monad
import Control.Monad.IO.Class
import Data.IORef
import Graphics.UI.Gtk hiding (Action, backspace)
-- import Graphics.UI.Gtk.TreeList (treeViewColumnAddAttribute)

hello :: (ButtonClass o) => o -> IO ()
hello b = set b [buttonLabel := "Hello World"]

data Pessoa = Pessoa { nome :: String, idade :: Int }



main :: IO ()
main = do
    void initGUI
    window <- windowNew

    set window [windowTitle := "Table", containerBorderWidth := 20,
        windowDefaultWidth := 450, windowDefaultHeight := 400]

    table   <- tableNew 6 2 True
    containerAdd window table

    label <- labelNew (Just "Lista de pessoas:")
    tableAttachDefaults table label 0 2 0 1

    button3 <- buttonNewWithLabel "Quit"
    onClicked button3 mainQuit
    tableAttachDefaults table button3 0 2 5 6

    -- Cria um modelo de dados usando um ListStore
    model <- listStoreNew [Pessoa "João da Silva" 30
        , Pessoa "Maria da Chica" 25
        , Pessoa "Pedro Golzaga" 40]

    -- Cria um componente de GtkTreeView
    treeView <- treeViewNewWithModel model

    -- Cria uma coluna para o nome da pessoa
    nameColumn <- treeViewColumnNew
    cellRendererName <- cellRendererTextNew
    treeViewColumnPackStart nameColumn cellRendererName False
    treeViewColumnSetTitle nameColumn "Nome"

    cellLayoutSetAttributes nameColumn cellRendererName model
            $ \(Pessoa n _) -> [cellText := n]

    treeViewAppendColumn treeView nameColumn

    -- Cria uma coluna para a idade da pessoa
    ageColumn <- treeViewColumnNew
    cellRendererAge <- cellRendererTextNew
    treeViewColumnPackStart ageColumn cellRendererAge True
    treeViewColumnSetTitle ageColumn "Idade"

    cellLayoutSetAttributes ageColumn cellRendererAge model
            $ \(Pessoa _ a) -> [cellText := show a]
    treeViewAppendColumn treeView ageColumn

    treeSelection <- treeViewGetSelection treeView
    treeSelectionSetMode treeSelection  SelectionSingle
    -- onSelectionChanged treeSelection (oneSelection model treeSelection)

    -- adiciona a tree na janela
    tableAttachDefaults table treeView 0 2 1 3

    -- acao do botao incluir
    buttonIncluir <- buttonNewWithLabel "Incluir"
    onClicked buttonIncluir (addButton model)
    tableAttachDefaults table buttonIncluir 0 1 3 4

    buttonExcluir <- buttonNewWithLabel "Excluir"
    onClicked buttonExcluir (removerElementoDaLista model treeSelection)
    tableAttachDefaults table buttonExcluir 0 1 4 5

    buttonAlterar <- buttonNewWithLabel "Alterar"
    onClicked buttonAlterar (alterarElementoDaLista model treeSelection)
    tableAttachDefaults table buttonAlterar 1 2 3 4

    onDestroy window mainQuit

    widgetShowAll window
    mainGUI

-- precisei desabilitar a funcao pois estava dando erro com o excluir
-- oneSelection :: ListStore Pessoa -> TreeSelection ->  IO ()
-- oneSelection list tree = do
--     sel <- treeSelectionGetSelectedRows tree
--     let s = head (head sel)
--     (Pessoa nome1 _) <- listStoreGetValue list s
--     putStrLn $ "selected " ++ nome1

-- Cria um botão para adicionar uma nova pessoa
addButton :: ListStore Pessoa -> IO ()
addButton list = do
    -- Adiciona uma nova pessoa à lista
    let pessoa = Pessoa "New Player" 30
    listStoreAppend list pessoa
    return ()

removerElementoDaLista :: ListStore Pessoa -> TreeSelection -> IO ()
removerElementoDaLista list treeS = do
    index <- getIndexFromSelection treeS list
    case index of
        Nothing  -> return ()
        -- exemplo de debug
        -- (Just i) -> putStrLn $ "teste: " ++ show i --
        (Just i) -> removeFromListStore list i
    return ()

removeFromListStore :: ListStore Pessoa -> Int -> IO ()
removeFromListStore store index = do
    -- Remove o valor no índice especificado
    listStoreRemove store index
    return ()


-- Obtém o índice do primeiro elemento selecionado na TreeView
getIndexFromSelection :: TreeSelection -> ListStore a -> IO (Maybe Int)
getIndexFromSelection tree model = do
    sel <- treeSelectionGetSelectedRows tree
    let s = head (head sel)
    return (Just s)


alterarPessoaNaPosicao :: ListStore Pessoa -> Int -> Pessoa -> IO ()
alterarPessoaNaPosicao listStore x novaPessoa = do
    -- verifica se o índice é válido
    nItens <- listStoreGetSize listStore
    if x >= 0 && x < nItens then do
        -- pega a pessoa antiga da posição x
        oldPessoa <- listStoreGetValue listStore x
        -- remove a pessoa antiga da posição x
        listStoreRemove listStore x
        -- insere a nova pessoa na posição x
        listStoreInsert listStore x novaPessoa
        return ()
    else do
        return ()


alterarElementoDaLista :: ListStore Pessoa -> TreeSelection -> IO ()
alterarElementoDaLista list treeS = do
    index <- getIndexFromSelection treeS list
    case index of
        Nothing  -> return ()
        -- exemplo de debug
        -- (Just i) -> putStrLn $ "teste: " ++ show i --
        (Just i) -> alterarPessoaNaPosicao list i (Pessoa "Alterando a pessoa" 30)
    return ()
